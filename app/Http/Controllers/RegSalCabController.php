<?php

namespace App\Http\Controllers;

use App\Http\Requests\FormReg_sal_cab;
use App\Http\Requests\FormReg_sal_cabUpdate;

use App\Models\Reg_sal_cab;
use App\Models\Reg_sal_det;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RegSalCabController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:ver-salidas de insumo|registrar-salidas de insumo|editar-salidas de insumo|eliminar-salidas de insumo')->only(['index','show']);
        $this->middleware('permission:registrar-salidas de insumo')->only(['create','store']);
        $this->middleware('permission:editar-salidas de insumo')->only(['edit','update']);
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
    
        $regs_sal = DB::table('reg_sal_cab as rc')
        ->join('almacen as a','rc.cod_almacen','=','a.cod_almacen')
        ->join('tipo_transf as tt','rc.cod_t_transf','=','tt.cod_t_transf')
        ->join('persona as pAut','rc.cod_autorizador','=','pAut.cod_persona')
        ->join('persona as pSol','rc.cod_solicitador','=','pSol.cod_persona')
        ->select('rc.cod_reg_sal',DB::raw("CONCAT(pAut.nom_per,' ',pAut.ape_pat_per,' ',pAut.ape_mat_per) AS autoriza"),DB::raw("CONCAT(pSol.nom_per,' ',pSol.ape_pat_per,' ',pSol.ape_mat_per) AS solicita"),'a.des_almacen','tt.des_transf','rc.fec_sal')
        ->where('a.des_almacen','LIKE', '%'.$busqueda.'%')
        ->wherein('a.des_almacen',$accesos)
        ->orwhere(DB::raw('CONCAT(pAut.nom_per," ",pAut.ape_pat_per," ",pAut.ape_mat_per)'),'LIKE', '%'.$busqueda.'%') 
        ->orwhere(DB::raw('CONCAT(pSol.nom_per," ",pSol.ape_pat_per," ",pSol.ape_mat_per)'),'LIKE', '%'.$busqueda.'%') 
        ->orwhere('tt.des_transf','LIKE', '%'.$busqueda.'%')
        ->orwhere('rc.fec_sal','LIKE', '%'.$busqueda.'%')
        ->orderBy('rc.fec_sal','desc')
        ->paginate(8);

        return response()->json([
            "registros"=>$regs_sal
        ], 200,);
    }

    public function create()
    {
        // solicitante , autorizante , almacen , tipo transaferencia, tipo documento, 
        //articulo con codigo, descripcion y um, estados

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
        ->where('tipo_reg_doc','=','Salida')
        ->where('estado_t_doc',1)
        ->orderBy('cod_t_doc','asc')
        ->get();
         
        return response()->json([
            "almacen"=>$almacen,
            "tipo_transf"=>$tipo_transf,
            "tipo_doc_reg"=>$tipo_doc_reg
        ], 200,);
    }

    public function trabajadorSolicitante($id)
    {

        $trabajador = DB::table('trabajador as tSoli')
        ->join('persona as p','p.cod_persona','tSoli.cod_trabajador')
        ->join('users as us','us.cod_trabajador','tSoli.cod_trabajador')
        ->join('model_has_permissions as mper','mper.model_id','us.id')
        ->join('permissions as per','per.id','mper.permission_id')
        ->join('acceso as acc','acc.id','per.id')
        ->join('almacen as alm','alm.cod_almacen','acc.id_almacen')
        ->select('tSoli.cod_trabajador',DB::raw("CONCAT(p.nom_per,' ',p.ape_pat_per,' ',p.ape_mat_per,' | ',p.nro_doc) AS documento"))
        ->where('alm.cod_almacen',$id)
        ->where('tSoli.estado_trab',1)
        ->get();

        return response()->json([
            "solicitante" => $trabajador
        ], 200);

    }

    public function trabajadorAtorizador($id)
    {

        $trabajador = DB::table('trabajador as tAut')
        ->join('persona as p','p.cod_persona','tAut.cod_trabajador')
        ->join('users as us','us.cod_trabajador','tAut.cod_trabajador')
        ->join('model_has_permissions as mper','mper.model_id','us.id')
        ->join('permissions as per','per.id','mper.permission_id')
        ->join('acceso as acc','acc.id','per.id')
        ->join('almacen as alm','alm.cod_almacen','acc.id_almacen')
        ->join('model_has_roles as mr','mr.model_id','=','us.id')
        ->join('roles as r','r.id','=','mr.role_id')
        ->join('autorizar as au','au.id','r.id')
        ->select('tAut.cod_trabajador',DB::raw("CONCAT(p.nom_per,' ',p.ape_pat_per,' ',p.ape_mat_per,' | ',p.nro_doc) AS documento"))
        ->where('alm.cod_almacen',$id)
        ->where('tAut.estado_trab',1)
        ->get();

        return response()->json([
            "autorizador" => $trabajador
        ], 200);

    }

    public function articulos($id)
    {
        $articulos = DB::table('articulo as art')
        ->join('unid_med as um','art.cod_unid_med','=','um.cod_unid_med')
        ->join('inventario as inv','art.cod_art','=','inv.cod_art')
        ->select('art.cod_art',DB::raw("CONCAT(art.des_art,' | ',um.prefijo_unid_med) as articulo"),'inv.stock_almacen')// falta precio
        //where stock mayor a 0
        ->where('inv.stock_almacen','>','0')
        ->where('cod_almacen','=',$id)
        ->where('art.cod_estado_art',1)
        ->orderBy('art.des_art','asc')
        ->get();

        return response()->json([
            "articulos"=>$articulos
        ], 200,);
    }

    public function store(FormReg_sal_cab $request)
    {
        $msg ="sin error";
        try{
            DB::beginTransaction();
            $reg_sal_cab = new Reg_sal_cab();
            $reg_sal_cab->cod_solicitador = $request->get('cod_solicitador');
            $reg_sal_cab->cod_autorizador = $request->get('cod_autorizador');
            $reg_sal_cab->cod_almacen = $request->get('cod_almacen');
            $reg_sal_cab->cod_t_transf = $request->get('cod_t_transf');
            $reg_sal_cab->cod_t_doc = $request->get('cod_t_doc');
            $reg_sal_cab->nro_doc = $request->get('nro_doc');
            $reg_sal_cab->fec_doc = $request->get('fec_doc'); //2014-10-25
            //$reg_sal_cab->cod_estado_reg = $request->get('cod_estado_reg');
            //$reg_sal_cab->tot_pagar = $request->get('tot_pagar');
            $reg_sal_cab->save();

            $cod_art = $request->get('cod_art');
            $cant_art = $request->get('cant_art');
           // $prec_sal = $request->get('prec_sal');
            $obs_sal = $request->get('obs_sal');

            $cont=0;

            while($cont < count($cod_art)){
                // B- primer registro detalle
                $id_reg_sal_det = $reg_sal_cab->cod_reg_sal;
                $cod_art_detalle = $cod_art[$cont];
                $cant_a_retirar = $cant_art[$cont];
                
                $cont_art = 0;
                while ($cant_a_retirar>0){
                    // B- obtener el registro mas antiguo para actualizar o eliminar
                     $art_ing_antiguo = DB::table('reg_ing_aux')
                     //->select('fec_ing','prec_art','cant_art')
                     ->where('reg_ing_aux.cod_art','=',$cod_art_detalle)
                     ->where('cod_almacen','=',$reg_sal_cab->cod_almacen)
                    ->orderBy('fec_ing','asc')
                     ->first();
                    //B- extraigo los datos del registro antiguo
                    //A- agregar el ID del registro de ingreso
                    $cantidad_reg_antiguo = $art_ing_antiguo->cant_art;
                    $precio_reg_antiguo = $art_ing_antiguo->prec_art;
                    $fecha_reg_antiguo = $art_ing_antiguo->fec_ing;
                    $id_ing_antiguo = $art_ing_antiguo->id_reg_ing;
                    $cod_almacen_reg_antiguo = $art_ing_antiguo->cod_almacen;
                    $cod_art_reg_antiguo = $art_ing_antiguo->cod_art;

                    if($cantidad_reg_antiguo <= $cant_a_retirar){
                        $cant_a_retirar = $cant_a_retirar - $cantidad_reg_antiguo;
                        $cantidad_retirada = $cantidad_reg_antiguo;
                        //update tabla_aux_ing set cant_art = 0 where coincida el articulo y la fecha ..... triger despues de un update si el art es 0, delete
                        DB::table('reg_ing_aux')
                        ->where('fec_ing', $fecha_reg_antiguo)
                        ->where('cod_art', $cod_art_detalle)
                        ->where('cod_almacen','=',$reg_sal_cab->cod_almacen)
                        ->delete();

                        //B- insertar en la tabla reg_sal_aux
                       DB::table('reg_sal_aux')->insert(
                            ['id_reg_sal' => $id_reg_sal_det,
                            'id_reg_ing' => $id_ing_antiguo , 'fec_ing' =>$fecha_reg_antiguo , 
                            'cod_almacen' =>$cod_almacen_reg_antiguo , 'cod_art' => $cod_art_reg_antiguo ,
                            'prec_art' =>$precio_reg_antiguo , 'cant_art' => $cantidad_retirada  ]
                        );
                    }else{
                        $nuevo_cantidad_registro_antiguo = $cantidad_reg_antiguo - $cant_a_retirar;
                        $cantidad_retirada = $cant_a_retirar;
                        $cant_a_retirar = 0;
                        //update  tabla_aux_ing set cant_art = $nuevo_cantidad_registro_antiguo;
                        DB::table('reg_ing_aux')
                        ->where('fec_ing', $fecha_reg_antiguo)
                        ->where('cod_art', $cod_art_detalle)
                        ->where('cod_almacen','=',$reg_sal_cab->cod_almacen)
                        ->update(['cant_art' => $nuevo_cantidad_registro_antiguo]);

                        //B- insertar en la tabla reg_sal_aux
                        DB::table('reg_sal_aux')->insert(
                            ['id_reg_sal' => $id_reg_sal_det,
                            'id_reg_ing' => $id_ing_antiguo , 'fec_ing' =>$fecha_reg_antiguo , 
                            'cod_almacen' =>$cod_almacen_reg_antiguo , 'cod_art' => $cod_art_reg_antiguo ,
                            'prec_art' =>$precio_reg_antiguo , 'cant_art' => $cantidad_retirada  ]
                        );
                    }

                    $reg_sal_det[$cont_art] = new Reg_sal_det();
                    $reg_sal_det[$cont_art]->prec_sal = $precio_reg_antiguo;

                    $nuevo = true;
                    for( $i=0; $i < $cont_art; $i++){
                        if($reg_sal_det[$i]->prec_sal ==  $reg_sal_det[$cont_art]->prec_sal){
                            $reg_sal_det[$i]->cant_art += $cantidad_retirada;
                            $nuevo = false;
                        }
                    }

                    if($nuevo){
                        $reg_sal_det[$cont_art]->cod_reg_sal = $id_reg_sal_det;
                        $reg_sal_det[$cont_art]->cod_art = $cod_art[$cont];
                        $reg_sal_det[$cont_art]->cant_art = $cantidad_retirada;
                        //validar vacio observacion
                        $reg_sal_det[$cont_art]->obs_sal = $obs_sal[$cont];
                        //$reg_sal_det->save();
                        $cont_art++;
                    }
                }

                for($i=0; $i<$cont_art; $i++){
                    $regSal = $reg_sal_det[$i]->cod_reg_sal;
                    $codArt = $reg_sal_det[$i]->cod_art;
                    $cantArt = $reg_sal_det[$i]->cant_art;
                    $precSal = $reg_sal_det[$i]->prec_sal;
                    $obsSal = $reg_sal_det[$i]->obs_sal;
                    // DB::insert('insert into reg_sal_det (cod_reg_sal,cod_art,cant_art,prec_sal,obs_sal) values(?,?,?,?,?)',[$regSal,$codArt,$cantArt,$precSal,$obsSal]);
                    
                    DB::table('reg_sal_det')->insert(
                        ['cod_reg_sal' => $regSal, 'cod_art' => $codArt,'cant_art' => $cantArt,'prec_sal' => $precSal, 'obs_sal' =>$obsSal]
                    );
                }
                $cont++;
            }

            DB::commit();

        }catch(Exception $e){   
            DB::rollBack();
            return response()->json([
                'msg' => "error",
                "errores" => $e
            ]);
        }
        return response()->json([
            'msg' => $msg
        ]);
        
    }

    public function show($id)
    {
        $reg_sal_det = DB::table('reg_sal_det as rd')
        ->join('articulo as art','rd.cod_art','=','art.cod_art')
        ->join('unid_med as um','art.cod_unid_med','=','um.cod_unid_med')
        ->select('art.cod_art','art.des_art','um.des_unid_med','rd.cant_art','rd.prec_sal',DB::raw('(rd.cant_art*rd.prec_sal) as prec_total_sal'),'rd.obs_sal')
        ->where('rd.cod_reg_sal','=',$id)
        ->get();

        $reg_sal_cab = DB::table('reg_sal_cab as rc')
        ->join('persona as sol','rc.cod_solicitador','=','sol.cod_persona')
        ->join('persona as aut','rc.cod_autorizador','=','aut.cod_persona')
        ->join('almacen as a','rc.cod_almacen','=','a.cod_almacen')
        ->join('tipo_transf as tt','rc.cod_t_transf','=','tt.cod_t_transf')
        ->join('tipo_doc_reg as td','rc.cod_t_doc','=','td.cod_t_doc')
        ->join('estado_registro as er','rc.cod_estado_reg','=','er.cod_estado_reg')
        ->join( 'reg_sal_det as rsd', 'rsd.cod_reg_sal', '=' ,'rc.cod_reg_sal')
        ->select('rc.cod_reg_sal',DB::raw("CONCAT(sol.nom_per,' ',sol.ape_pat_per,' ',sol.ape_mat_per) AS solicitador"),
            DB::raw("CONCAT(aut.nom_per,' ',aut.ape_pat_per,' ',aut.ape_mat_per) AS autorizador"),
            'a.des_almacen','tt.des_transf','td.des_t_doc','rc.nro_doc','rc.fec_doc','rc.fec_sal',
            DB::raw('SUM(rsd.cant_art*rsd.prec_sal) AS tot_pagar'))
        ->where('rc.cod_reg_sal','=',$id)
        ->first();
        
        return response()->json([
            "cabecera" => $reg_sal_cab,
            "detalles" => $reg_sal_det
        ], 200, );
    }

    public function edit($id)
    {
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
        ->where('tipo_reg_doc','=','Salida')
        ->orderBy('cod_t_doc','asc')
        ->get();

        $reg_sal_cab = DB::table('reg_sal_cab')
        ->select('cod_reg_sal','cod_solicitador','cod_autorizador','cod_almacen','cod_t_transf','cod_t_doc','nro_doc','fec_doc')
        ->where('cod_reg_sal','=',$id)
        ->first();

        // $reg_sal_det = DB::table('reg_sal_det')
        // ->select('cod_art',DB::raw("SUM(cant_art) as cant_art"),'obs_sal')
        // ->where('cod_reg_sal','=',$id)
        // ->groupby('cod_art')
        // ->get();
        $reg_sal_det = DB::select("SELECT rd.cod_art,SUM(rd.cant_art) as cant_art,rd.obs_sal,
        (select inv.stock_almacen FROM inventario as inv 
        INNER JOIN reg_sal_cab as rb on rb.cod_reg_sal = rd.cod_reg_sal
        WHERE inv.cod_almacen = rb.cod_almacen and inv.cod_art = rd.cod_art) as stock_almacen
        FROM reg_sal_det as rd
        WHERE rd.cod_reg_sal = $id
        GROUP BY rd.cod_art ");
        
        return response()->json([
            "salida_cabecera" => $reg_sal_cab,
            "salida_detalles" => $reg_sal_det,

            "almacen"=>$almacen,
            "tipo_transf"=>$tipo_transf,
            "tipo_doc_reg"=>$tipo_doc_reg
        ], 200);

    }

    public function update(FormReg_sal_cabUpdate $request, $id)
    {
        $msg ="sin error";
        //$mensajes = array();
        try{
            DB::beginTransaction();

            DB::delete('delete from reg_sal_det where cod_reg_sal = ?',[$id]);

            $reg_sal_antiguo =  DB::table('reg_sal_aux')
            ->where('id_reg_sal',$id)
            ->get();

            DB::delete('delete from reg_sal_aux where id_reg_sal = ?',[$id]);

            foreach($reg_sal_antiguo as $rsa){
                $dato_ing_aux = DB::table('reg_ing_aux')
                ->where('id_reg_ing',$rsa->id_reg_ing)
                ->where('fec_ing',$rsa->fec_ing)
                ->where('cod_art',$rsa->cod_art)
                ->where('prec_art',$rsa->prec_art)
                ->first();

                if($dato_ing_aux != null){
                    $nueva_cant = ($dato_ing_aux->cant_art + $rsa->cant_art);
                    DB::table('reg_ing_aux')
                    ->where('id_reg_ing',$rsa->id_reg_ing)
                    ->where('fec_ing',$rsa->fec_ing)
                    ->where('cod_art',$rsa->cod_art)
                    ->where('prec_art',$rsa->prec_art)
                    ->update(['cant_art' => $nueva_cant]);
                    //array_push($mensajes,"actualizar reg_ing_aux".$rsa->id_reg_ing);
                }else{
                    DB::insert('insert into reg_ing_aux (id_reg_ing, fec_ing, cod_almacen, cod_art, prec_art, cant_art) 
                                values (?,?,?,?,?,?)', array($rsa->id_reg_ing, $rsa->fec_ing, $rsa->cod_almacen, $rsa->cod_art, $rsa->prec_art, $rsa->cant_art));
                   // array_push($mensajes,"insertar reg_ing_aux".$rsa->id_reg_ing);
                }
            }

            $reg_sal_cab = Reg_sal_cab::find($id);
            $reg_sal_cab->cod_solicitador = $request->get('cod_solicitador');
            $reg_sal_cab->cod_autorizador = $request->get('cod_autorizador');
            $reg_sal_cab->cod_almacen = $request->get('cod_almacen');
            $reg_sal_cab->cod_t_transf = $request->get('cod_t_transf');
            $reg_sal_cab->cod_t_doc = $request->get('cod_t_doc');
            $reg_sal_cab->nro_doc = $request->get('nro_doc');
            $reg_sal_cab->fec_doc = $request->get('fec_doc'); //2014-10-25
            //$reg_sal_cab->cod_estado_reg = $request->get('cod_estado_reg');
            //$reg_sal_cab->tot_pagar = $request->get('tot_pagar');
            $reg_sal_cab->update();

            $cod_art = $request->get('cod_art');
            $cant_art = $request->get('cant_art');
           // $prec_sal = $request->get('prec_sal');
            $obs_sal = $request->get('obs_sal');

            $cont=0;

            while($cont < count($cod_art)){
                // B- primer registro detalle
                $id_reg_sal_det = $reg_sal_cab->cod_reg_sal;
                $cod_art_detalle = $cod_art[$cont];
                $cant_a_retirar = $cant_art[$cont];
                
                $cont_art = 0;
                while ($cant_a_retirar>0){
                    // B- obtener el registro mas antiguo para actualizar o eliminar
                     $art_ing_antiguo = DB::table('reg_ing_aux')
                     //->select('fec_ing','prec_art','cant_art')
                     ->where('reg_ing_aux.cod_art','=',$cod_art_detalle)
                     ->where('cod_almacen','=',$reg_sal_cab->cod_almacen)
                    ->orderBy('fec_ing','asc')
                     ->first();
                    //B- extraigo los datos del registro antiguo
                    //A- agregar el ID del registro de ingreso
                    $cantidad_reg_antiguo = $art_ing_antiguo->cant_art;
                    $precio_reg_antiguo = $art_ing_antiguo->prec_art;
                    $fecha_reg_antiguo = $art_ing_antiguo->fec_ing;
                    $id_ing_antiguo = $art_ing_antiguo->id_reg_ing;
                    $cod_almacen_reg_antiguo = $art_ing_antiguo->cod_almacen;
                    $cod_art_reg_antiguo = $art_ing_antiguo->cod_art;

                    if($cantidad_reg_antiguo <= $cant_a_retirar){
                        $cant_a_retirar = $cant_a_retirar - $cantidad_reg_antiguo;
                        $cantidad_retirada = $cantidad_reg_antiguo;
                        //update tabla_aux_ing set cant_art = 0 where coincida el articulo y la fecha ..... triger despues de un update si el art es 0, delete
                        DB::table('reg_ing_aux')
                        ->where('fec_ing', $fecha_reg_antiguo)
                        ->where('cod_art', $cod_art_detalle)
                        ->where('cod_almacen','=',$reg_sal_cab->cod_almacen)
                        ->delete();

                        //B- insertar en la tabla reg_sal_aux
                       DB::table('reg_sal_aux')->insert(
                            ['id_reg_sal' => $id_reg_sal_det,
                            'id_reg_ing' => $id_ing_antiguo , 'fec_ing' =>$fecha_reg_antiguo , 
                            'cod_almacen' =>$cod_almacen_reg_antiguo , 'cod_art' => $cod_art_reg_antiguo ,
                            'prec_art' =>$precio_reg_antiguo , 'cant_art' => $cantidad_retirada  ]
                        );
                    }else{
                        $nuevo_cantidad_registro_antiguo = $cantidad_reg_antiguo - $cant_a_retirar;
                        $cantidad_retirada = $cant_a_retirar;
                        $cant_a_retirar = 0;
                        //update  tabla_aux_ing set cant_art = $nuevo_cantidad_registro_antiguo;
                        DB::table('reg_ing_aux')
                        ->where('fec_ing', $fecha_reg_antiguo)
                        ->where('cod_art', $cod_art_detalle)
                        ->where('cod_almacen','=',$reg_sal_cab->cod_almacen)
                        ->update(['cant_art' => $nuevo_cantidad_registro_antiguo]);

                        //B- insertar en la tabla reg_sal_aux
                        DB::table('reg_sal_aux')->insert(
                            ['id_reg_sal' => $id_reg_sal_det,
                            'id_reg_ing' => $id_ing_antiguo , 'fec_ing' =>$fecha_reg_antiguo , 
                            'cod_almacen' =>$cod_almacen_reg_antiguo , 'cod_art' => $cod_art_reg_antiguo ,
                            'prec_art' =>$precio_reg_antiguo , 'cant_art' => $cantidad_retirada  ]
                        );
                    }

                    $reg_sal_det[$cont_art] = new Reg_sal_det();
                    $reg_sal_det[$cont_art]->prec_sal = $precio_reg_antiguo;

                    $nuevo = true;
                    for( $i=0; $i < $cont_art; $i++){
                        if($reg_sal_det[$i]->prec_sal ==  $reg_sal_det[$cont_art]->prec_sal){
                            $reg_sal_det[$i]->cant_art += $cantidad_retirada;
                            $nuevo = false;
                        }
                    }

                    if($nuevo){
                        $reg_sal_det[$cont_art]->cod_reg_sal = $id_reg_sal_det;
                        $reg_sal_det[$cont_art]->cod_art = $cod_art[$cont];
                        $reg_sal_det[$cont_art]->cant_art = $cantidad_retirada;
                        //validar vacio observacion
                        $reg_sal_det[$cont_art]->obs_sal = $obs_sal[$cont];
                        //$reg_sal_det->save();
                        $cont_art++;
                    }
                }

                for($i=0; $i<$cont_art; $i++){
                    $regSal = $reg_sal_det[$i]->cod_reg_sal;
                    $codArt = $reg_sal_det[$i]->cod_art;
                    $cantArt = $reg_sal_det[$i]->cant_art;
                    $precSal = $reg_sal_det[$i]->prec_sal;
                    $obsSal = $reg_sal_det[$i]->obs_sal;
                    // DB::insert('insert into reg_sal_det (cod_reg_sal,cod_art,cant_art,prec_sal,obs_sal) values(?,?,?,?,?)',[$regSal,$codArt,$cantArt,$precSal,$obsSal]);
                    
                    DB::table('reg_sal_det')->insert(
                        ['cod_reg_sal' => $regSal, 'cod_art' => $codArt,'cant_art' => $cantArt,'prec_sal' => $precSal, 'obs_sal' =>$obsSal]
                    );
                }
                $cont++;
            }

            DB::commit();

        }catch(Exception $e){   
            DB::rollBack();
            return response()->json([
                'msg' => "error",
                "errores" => $e
            ]);
        }
        return response()->json([
            'msg' => $msg,
            //"acciones" => $mensajes

        ]);

    }

}
