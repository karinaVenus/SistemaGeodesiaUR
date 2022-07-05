<?php

namespace App\Http\Controllers;

use App\Http\Requests\FormReg_ing_cab;
use App\Http\Requests\FormReg_ing_cabUpdate;
use App\Models\Reg_ing_cab;
use App\Models\Reg_ing_det;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
class RegIngCabController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:ver-ingresos de insumo|registrar-ingresos de insumo|editar-ingresos de insumo|eliminar-ingresos de insumo')->only(['index','show']);
        $this->middleware('permission:registrar-ingresos de insumo')->only(['create','store']);
        $this->middleware('permission:editar-ingresos de insumo')->only(['edit','update']);
    }
    
    public function index(Request $request)
    {
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }

        $accesos = array();
        $user = auth()->user()->getDirectPermissions();
        foreach($user as $u){
            array_push($accesos, $u->name);
        }

        $regs_ings = DB::table('reg_ing_cab as rc')
        ->join('proveedor as p','rc.cod_prov','=','p.cod_prov')
        ->join('trabajador as t','rc.cod_trabajador','=','t.cod_trabajador')
        ->join('almacen as a','rc.cod_almacen','=','a.cod_almacen')
        ->join('tipo_transf as tt','rc.cod_t_transf','=','tt.cod_t_transf')
        ->join('persona as pep','p.cod_prov','=','pep.cod_persona')
        ->join('persona as pet','t.cod_trabajador','=','pet.cod_persona')
        ->select('rc.cod_reg_in','pep.razon_social AS proveedor',DB::raw("CONCAT(pet.nom_per,' ',pet.ape_pat_per,' ',pet.ape_mat_per) AS trabajador"),'a.des_almacen','tt.des_transf','rc.fec_ing')
        ->where(DB::raw('CONCAT(pet.nom_per," ",pet.ape_pat_per," ",pet.ape_mat_per)'),'LIKE', '%'.$busqueda.'%') 
        ->orwhere('a.des_almacen','LIKE','%'.$busqueda.'%')
        ->orwhere('pep.razon_social','LIKE', '%'.$busqueda.'%') 
        ->orwhere('tt.des_transf','LIKE', '%'.$busqueda.'%') 
        ->orwhere('rc.fec_ing','LIKE', '%'.$busqueda.'%') 
        ->wherein('a.des_almacen',$accesos)
        ->orderBy('rc.fec_ing','desc')
        ->get();
        $data = array('data' => $regs_ings); 
        return response()->json([
            "registros"=>$data
        ], 200,);
    }
  
    public function create()
    {
        $proveedor = DB::table('proveedor as p')
        ->join('persona as pep','p.cod_prov','=','pep.cod_persona')
        ->join('tdoc_ide as tdi','pep.cod_t_doc','=','tdi.cod_t_doc')
        ->select('p.cod_prov',DB::raw("CONCAT(pep.razon_social,'|',tdi.dest_doc,': ',pep.nro_doc) AS proveedor"))
        ->where('p.estado_prov',1)
        ->orderBy('p.cod_prov','asc')
        ->get();

        $accesos = array();
        $user = auth()->user()->getDirectPermissions();
        foreach($user as $u){
            array_push($accesos, $u->name);
        }
        $almacen = DB::table('almacen')
        ->select('cod_almacen','des_almacen')
        ->where('cod_estado_almacen',1)
        ->wherein('des_almacen',$accesos)
        ->orderBy('des_almacen','asc')
        ->get();
       
        $tipo_transf = DB::table('tipo_transf')
        ->select('cod_t_transf','des_transf')
        ->where('estado_transf','Activo')
        ->orderBy('cod_t_transf','asc')
        ->get();

        $tipo_doc_reg = DB::table('tipo_doc_reg')
        ->select('cod_t_doc','des_t_doc')
        ->where('tipo_reg_doc','=','Ingreso')
        ->where('estado_t_doc',1)
        ->orderBy('cod_t_doc','asc')
        ->get();

        $articulo = DB::table('articulo as art')
        ->join('presentacion as pr','art.cod_pres','=','pr.cod_pres')
        ->select('art.cod_art',DB::raw("CONCAT(art.des_art,' / ',pr.des_pres) AS articulo"))
        ->where('art.cod_estado_art',1)
        ->orderBy('art.cod_art','asc')
        ->get();
         
        return response()->json([
            "proveedor"=>$proveedor,
            "almacen"=>$almacen,
            "tipo_transf"=>$tipo_transf,
            "tipo_doc_reg"=>$tipo_doc_reg,
            "articulo" => $articulo
        ], 200);


    }

    public function trabajador($id){
        $trabajador = DB::table('trabajador as t')
        ->join('persona as pet','t.cod_trabajador','=','pet.cod_persona')
        ->join('users as u','u.cod_trabajador','=','t.cod_trabajador')
        ->join('model_has_roles as mr','mr.model_id','=','u.id')

        ->join('model_has_permissions as mper','mper.model_id','u.id')
        ->join('permissions as per','per.id','mper.permission_id')
        ->join('acceso as acc','acc.id','per.id')
        ->join('almacen as alm','alm.cod_almacen','acc.id_almacen')

        ->join('roles as r','r.id','=','mr.role_id')
        ->join('role_has_permissions as rp','rp.role_id','=','r.id')
        ->join('permissions as p','p.id','=','rp.permission_id')
        ->join('tdoc_ide as tdi','pet.cod_t_doc','=','tdi.cod_t_doc')
        ->select('t.cod_trabajador',DB::raw("CONCAT(pet.nom_per,' ',pet.ape_pat_per,' ',pet.ape_mat_per,'|',tdi.dest_doc,': ',pet.nro_doc) AS trabajador"))
        ->where('t.estado_trab',1)
        ->where('alm.cod_almacen',$id)
        ->where('p.name','=','registrar-ingresos de insumo')
        ->orderBy('t.cod_trabajador','asc')
        ->get();

        

        return response()->json([
            "trabajador"=>$trabajador
        ], 200,);
    }

    public function store(FormReg_ing_cab $request)
    {
        //return $request;//Prueba mostrando datos
        $msg ="sin error";
        try{
            DB::beginTransaction();
            $reg_ing_cab = new Reg_ing_cab();
            $reg_ing_cab->cod_prov = $request->get('cod_prov');
            $reg_ing_cab->cod_trabajador = $request->get('cod_trabajador');
            $reg_ing_cab->cod_almacen = $request->get('cod_almacen');
            $reg_ing_cab->cod_t_transf = $request->get('cod_t_transf');
            $reg_ing_cab->cod_t_doc = $request->get('cod_t_doc');
            $reg_ing_cab->nro_doc = $request->get('nro_doc');
            $reg_ing_cab->fec_doc = $request->get('fec_doc'); //2014-10-25
            //$reg_ing_cab->cod_estado_reg = $request->get('cod_estado_reg');
            //$reg_ing_cab->tot_pagar = $request->get('tot_pagar');
            $reg_ing_cab->save();

            $cod_art = $request->get('cod_art');
            $prec_unit = $request->get('prec_unit');
            $cant_art = $request->get('cant_art');
            //$prec_compr = $request->get('prec_compr');
            $obs_ing = $request->get('obs_ing');

            $cont=0;
            while($cont < count($cod_art)){
                $reg_ing_det = new Reg_ing_det();
                $reg_ing_det->cod_reg_ing = $reg_ing_cab->cod_reg_in;

                $reg_ing_det->cod_art = $cod_art[$cont];
                $reg_ing_det->prec_unit = $prec_unit[$cont];
                $reg_ing_det->cant_art = $cant_art[$cont];
                $reg_ing_det->prec_compr = $prec_unit[$cont] * $cant_art[$cont];
                //$reg_ing_det->prec_compr = $prec_compr[$cont];
                //validar vacio observacion
                $reg_ing_det->obs_ing = $obs_ing[$cont];

                $reg_ing_det->save();

                $cont = $cont + 1;
            }

            DB::commit();

        }catch(Exception $e){
            $msg = "Error";
            DB::rollBack();
        }
        return response()->json([
            'msg' => $msg
        ]);
    }

    public function show($id)
    {
        $reg_ing_cab = DB::table('reg_ing_cab as rc')
        ->join('proveedor as p','rc.cod_prov','=','p.cod_prov')
        ->join('trabajador as t','rc.cod_trabajador','=','t.cod_trabajador')
        ->join('almacen as a','rc.cod_almacen','=','a.cod_almacen')
        ->join('tipo_transf as tt','rc.cod_t_transf','=','tt.cod_t_transf')
        ->join('tipo_doc_reg as td','rc.cod_t_doc','=','td.cod_t_doc')
        ->join('persona as pep','p.cod_prov','=','pep.cod_persona')
        ->join('persona as pet','t.cod_trabajador','=','pet.cod_persona')
        ->select('rc.cod_reg_in','pep.razon_social AS proveedor',DB::raw("CONCAT(pet.nom_per,' ',pet.ape_pat_per,' ',pet.ape_mat_per) AS trabajador"),'a.des_almacen','tt.des_transf','td.des_t_doc','rc.nro_doc','rc.fec_doc','rc.fec_ing')
        ->where('rc.cod_reg_in','=',$id)
        ->first();

        $reg_ing_det = DB::table('reg_ing_det as rd')
        ->join('articulo as art','rd.cod_art','=','art.cod_art')
        ->join('unid_med as um','art.cod_unid_med','=','um.cod_unid_med')
        ->select('art.cod_art','art.des_art','um.des_unid_med','rd.prec_unit','rd.cant_art','rd.prec_compr','rd.obs_ing')
        ->where('rd.cod_reg_ing','=',$id)
        ->get();
        $tot_pagar = DB::table('reg_ing_det')
        ->select(DB::raw("SUM(cant_art*prec_unit) as tot_pagar"))
        ->where('cod_reg_ing',$id)
        ->first();
        
        return response()->json([
            "cabecera" => $reg_ing_cab,
            "tot_pagar" => $tot_pagar->tot_pagar,
            "detalles" => $reg_ing_det,
        ], 200, );
    }

    public function edit($id)
    {
        $reg_ing_cab = DB::table('reg_ing_cab')
        ->select('cod_reg_in','cod_prov','cod_trabajador','cod_almacen','cod_t_transf','cod_t_doc','nro_doc','fec_doc')
        ->where('cod_reg_in','=',$id)
        ->first();

        $reg_ing_det = DB::table('reg_ing_det')
        ->select('cod_art','prec_unit','cant_art','obs_ing')
        ->where('cod_reg_ing','=',$id)
        ->get();

        $proveedor = DB::table('proveedor as p')
        ->join('persona as pep','p.cod_prov','=','pep.cod_persona')
        ->join('tdoc_ide as tdi','pep.cod_t_doc','=','tdi.cod_t_doc')
        ->select('p.cod_prov',DB::raw("CONCAT(pep.razon_social,'|',tdi.dest_doc,': ',pep.nro_doc) AS proveedor"))
        ->where('p.estado_prov',1)
        ->orderBy('p.cod_prov','asc')
        ->get();

        $accesos = array();
        $user = auth()->user()->getDirectPermissions();
        foreach($user as $u){
            array_push($accesos, $u->name);
        }
        $almacen = DB::table('almacen')
        ->select('cod_almacen','des_almacen')
        ->where('cod_estado_almacen',1)
        ->wherein('des_almacen',$accesos)
        ->orderBy('des_almacen','asc')
        ->get();

        $tipo_transf = DB::table('tipo_transf')
        ->select('cod_t_transf','des_transf')
        ->where('estado_transf','Activo')
        ->orderBy('cod_t_transf','asc')
        ->get();

        $tipo_doc_reg = DB::table('tipo_doc_reg')
        ->select('cod_t_doc','des_t_doc')
        ->where('estado_t_doc',1)
        ->where('tipo_reg_doc','=','Ingreso')
        ->orderBy('cod_t_doc','asc')
        ->get();

        $articulo = DB::table('articulo as art')
        ->join('unid_med as um','art.cod_unid_med','=','um.cod_unid_med')
        ->select('art.cod_art',DB::raw("CONCAT(art.des_art,'um: ',um.des_unid_med) AS articulo"))
        ->where('cod_estado_art',1)
        ->orderBy('art.cod_art','asc')
        ->get();

        return response()->json([
            "reg_ing_cab" => $reg_ing_cab,
            "reg_ing_det" => $reg_ing_det,

            "proveedor"=>$proveedor,
            "almacen"=>$almacen,
            "tipo_transf"=>$tipo_transf,
            "tipo_doc_reg"=>$tipo_doc_reg,
            "articulo" => $articulo
        ], 200,);
    }

    public function update(FormReg_ing_cabUpdate $request,$id)
    {
        try{
            DB::beginTransaction();

            DB::delete('delete from reg_ing_aux where id_reg_ing = ?',[$id]);
            DB::delete('delete from reg_ing_det where cod_reg_ing = ?',[$id]);

            $reg_ing_cab = Reg_ing_cab::find($id);
            $reg_ing_cab->cod_prov = $request->get('cod_prov');
            $reg_ing_cab->cod_trabajador = $request->get('cod_trabajador');
            $reg_ing_cab->cod_almacen = $request->get('cod_almacen');
            $reg_ing_cab->cod_t_transf = $request->get('cod_t_transf');
            $reg_ing_cab->cod_t_doc = $request->get('cod_t_doc');
            $reg_ing_cab->nro_doc = $request->get('nro_doc');
            $reg_ing_cab->fec_doc = $request->get('fec_doc'); //2014-10-25
            //$reg_ing_cab->tot_pagar = $request->get('tot_pagar');
            $reg_ing_cab->update();

            $cod_art = $request->get('cod_art');
            $prec_unit = $request->get('prec_unit');
            $cant_art = $request->get('cant_art');
            $prec_compr = $request->get('prec_compr');
            $obs_ing = $request->get('obs_ing');

            $cont=0;
            while($cont < count($cod_art)){
                $reg_ing_det = new Reg_ing_det();
                $reg_ing_det->cod_reg_ing = $id;
                $reg_ing_det->cod_art = $cod_art[$cont];
                $reg_ing_det->prec_unit = $prec_unit[$cont];
                $reg_ing_det->cant_art = $cant_art[$cont];
                $reg_ing_det->prec_compr = $prec_unit[$cont] * $cant_art[$cont] ;
                $reg_ing_det->obs_ing = $obs_ing[$cont];
                $reg_ing_det->save();

                $cont = $cont + 1;
            }

            DB::commit();

        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'msg' => "Error al actualizar ingreso",
                'Error' => $e
            ]);
        }
        return response()->json([
            'msg' => "Exito al actualizar registro"
        ]);
    }

}
