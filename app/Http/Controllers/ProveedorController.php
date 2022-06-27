<?php

namespace App\Http\Controllers;

use App\Http\Requests\FormProveedor;
use App\Http\Requests\FormProveedorUpdate;
use App\Models\Proveedor;
use App\Models\Persona;
use App\Models\Telefono;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProveedorController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:ver-proveedores|registrar-proveedores|editar-proveedores|eliminar-proveedores')->only(['index','show']);
        $this->middleware('permission:registrar-proveedores')->only(['create','store']);
        $this->middleware('permission:editar-proveedores')->only(['edit','update']);
        $this->middleware('permission:eliminar-proveedores')->only('destroy');
    }

    //codigo proveedor, tipo persona, razon social, tipo doc. identidad, nro. doc. identidad
    public function index(Request $request)
    {

        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }

        $proveedor = DB::table('proveedor as p')
            ->join('persona as pep','p.cod_prov','=','pep.cod_persona')
            ->select('p.cod_prov','pep.razon_social as proveedor','pep.nro_doc as ruc')
            ->where([['pep.razon_social','LIKE', '%'.$busqueda.'%'],['p.estado_prov',1]])
            ->orwhere([['pep.nro_doc','LIKE', '%'.$busqueda.'%'],['p.estado_prov',1]])
            ->orderBy('p.cod_prov','desc')
            ->paginate(7);

        return response()->json([
            "proveedor" => $proveedor
        ], 200);

    }

    //http://127.0.0.1:8000/api/proveedor/provincias/14    -> 14 es el codigo del departamento
    public function provincias($id)
    {
        $provincia = DB::table('provincia as provi') 
        ->join('departamento as dpt','provi.cod_dep','=','dpt.cod_dpt')
        ->select('provi.cod_provi','provi.des_provi')
        ->where('provi.cod_dep','=',$id)
        ->orderBy('provi.cod_provi','asc')
        ->get();
        return response()->json([
            "provincias"=>$provincia
        ], 200,);
    }

    //http://127.0.0.1:8000/api/proveedor/distritos/9     -> 9 es el codigo de la provincia
    public function distritos($id)
    {
        $distrito = DB::table('distrito as dist') 
        ->join('provincia as provi','dist.cod_provi','=','provi.cod_provi')
        ->select('dist.cod_dist','dist.des_distrito')
        ->where('dist.cod_provi','=',$id)
        ->orderBy('dist.cod_dist','asc')
        ->get();
        return response()->json([
            "distritos"=>$distrito
        ], 200,);
    }

    public function create()
    {
        $tdoc_ide = DB::table('tdoc_ide') 
        ->select('cod_t_doc','dest_doc')
        ->orderBy('cod_t_doc','asc')
        ->get();

        $departamento = DB::table('departamento') 
        ->select('cod_dpt','des_dpt')
        ->orderBy('cod_dpt','asc')
        ->get();

        $tipo_persona = DB::table('tipo_persona') 
        ->select('cod_t_per','des_t_per')
        ->orderBy('cod_t_per','asc')
        ->get();

        return response()->json([
            "tdoc_ide"=>$tdoc_ide,
            "departamento"=>$departamento,
            "tipo_persona"=>$tipo_persona
        ], 200,);
    }

    public function store(FormProveedor $request)
    {
        $msg ="sin error";
        try{
            DB::beginTransaction();
            $proveedor = new Persona();
            $proveedor->cod_t_per = $request->get('cod_t_per');
            $proveedor->razon_social = $request->get('razon_social');
            $proveedor->cod_t_doc = $request->get('cod_t_doc');
            $proveedor->nro_doc = $request->get('nro_doc');
            $proveedor->correo_per = $request->get('correo_per');
            $proveedor->cod_dist = $request->get('cod_dist');
            $proveedor->dir_per = $request->get('dir_per');
            $proveedor->save();

            $tbl_proveedor = new Proveedor();
            $tbl_proveedor->cod_prov =  $proveedor->cod_persona;//tabla proveedor
            //$tbl_proveedor->estado_prov = $request->get('estado_prov');//tabla proveedor
            $tbl_proveedor->save();

            $nro_telf = $request->get('nro_telf');
            
            $cont=0;
            
                while($cont < count($nro_telf)){
                    $telefono = new Telefono();
                    $telefono->cod_persona = $proveedor->cod_persona;

                    $telefono->nro_telf=$nro_telf[$cont];
        
                    $telefono->save();
        
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
        $proveedor = DB::table('proveedor as p')
        ->join('persona as pep','p.cod_prov','=','pep.cod_persona')
        ->join('tipo_persona as tp','pep.cod_t_per','=','tp.cod_t_per')
        ->join('tdoc_ide as tdi','pep.cod_t_doc','=','tdi.cod_t_doc')  
        ->join('distrito as dist','pep.cod_dist','=','dist.cod_dist')
        ->join('provincia as provi','dist.cod_provi','=','provi.cod_provi')
        ->join('departamento as dpt','provi.cod_dep','=','dpt.cod_dpt')
        ->select('p.cod_prov','tp.des_t_per','pep.razon_social as proveedor','tdi.dest_doc','pep.nro_doc','pep.correo_per','dpt.des_dpt','provi.des_provi','dist.des_distrito','pep.dir_per')
        ->where('p.cod_prov','=',$id)
        ->get();

        $telefono = DB::table('proveedor as p')
        ->join('persona as pep','p.cod_prov','=','pep.cod_persona')
        ->join('telefono as telf','pep.cod_persona','=','telf.cod_persona')
        ->select('telf.nro_telf')
        ->where('p.cod_prov','=',$id)
        ->get();

        return response()->json([
            'proveedor'=>$proveedor,
            'telefonos'=>$telefono
        ], 200,);
    }

    public function edit($id)
    {
        ////
        // AGREGAR PRECARGADOS PARA LA MODIFICACION
        ////
        $tdoc_ide = DB::table('tdoc_ide') 
        ->select('cod_t_doc','dest_doc')
        ->orderBy('cod_t_doc','asc')
        ->get();

        $departamento = DB::table('departamento') 
        ->select('cod_dpt','des_dpt')
        ->orderBy('cod_dpt','asc')
        ->get();

        $tipo_persona = DB::table('tipo_persona') 
        ->select('cod_t_per','des_t_per')
        ->orderBy('cod_t_per','asc')
        ->get();

        ///////
        $proveedor = DB::table('proveedor as p')
        ->join('persona as pep','p.cod_prov','=','pep.cod_persona')
        ->join('distrito as dist','pep.cod_dist','=','dist.cod_dist')
        ->join('provincia as provi','dist.cod_provi','=','provi.cod_provi')
        ->join('departamento as dpt','provi.cod_dep','=','dpt.cod_dpt')
        ->select('p.cod_prov','pep.cod_t_per','pep.razon_social','pep.cod_t_doc','pep.nro_doc',
                'pep.correo_per','dpt.cod_dpt','provi.cod_provi','pep.cod_dist','pep.dir_per')
        ->where('p.cod_prov','=',$id)
        ->first();

        $telefono = DB::table('proveedor as p')
        ->join('persona as pep','p.cod_prov','=','pep.cod_persona')
        ->join('telefono as telf','pep.cod_persona','=','telf.cod_persona')
        ->select('telf.nro_telf')
        ->where('p.cod_prov','=',$id)
        ->get();

        return response()->json([
            'proveedor'=>$proveedor,
            'telefonos'=>$telefono,
            
            "tdoc_ide"=>$tdoc_ide,
            "departamento"=>$departamento,
            "tipo_persona"=>$tipo_persona
        ], 200,);
    }

    public function update(FormProveedorUpdate $request,$id)
    {
        try{
            DB::beginTransaction();
            $proveedor = Persona::find($id);
            $proveedor->cod_t_per = $request->get('cod_t_per');
            $proveedor->razon_social = $request->get('razon_social');
            $proveedor->cod_t_doc = $request->get('cod_t_doc');
            $proveedor->nro_doc = $request->get('nro_doc');
            $proveedor->correo_per = $request->get('correo_per');
            $proveedor->cod_dist = $request->get('cod_dist');
            $proveedor->dir_per = $request->get('dir_per');
            $proveedor->update();

            $nro_telf = $request->get('nro_telf');
            DB::delete('delete from telefono where cod_persona = ?',[$id]);
            $cont=0;
                while($cont < count($nro_telf)){
                    $telefono = new Telefono();
                    $telefono->cod_persona = $id;
                    $telefono->nro_telf=$nro_telf[$cont];
                    $telefono->save();
        
                    $cont = $cont + 1;
                }
            if($proveedor->update()||$telefono->update()){
                $msg="Registro proveedor modificado";
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

    public function destroy($id)
    {
        try{
            DB::beginTransaction();
            DB::table('proveedor')
                ->where('cod_prov', $id) 
                ->limit(1)  
                ->update(array('estado_prov' => 0));
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'msg' => "error",
                "error" => $e
            ], 400 );
        }
        return response()->json([
            'msg' => "Proveedor deshabilitado"
        ], 200 );
    }
}
