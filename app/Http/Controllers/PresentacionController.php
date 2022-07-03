<?php

namespace App\Http\Controllers;

use App\Http\Requests\FormPresentacion;
use App\Http\Requests\FormPresentacionUpdate;
use App\Models\Presentacion;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PresentacionController extends Controller
{

    function __construct()
    {
        $this->middleware('permission:ver-presentaciones|registrar-presentaciones|editar-presentaciones|eliminar-presentaciones')->only(['index']);
        $this->middleware('permission:registrar-presentaciones')->only(['create','store']);
        $this->middleware('permission:editar-presentaciones')->only(['edit','update']);
        $this->middleware('permission:eliminar-presentaciones')->only(['destroy','indexDeleted','restore']);
    }

    public function index(Request $request)
    {
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }

        $presentacion = DB::table('presentacion')
            ->select('cod_pres','des_pres')
            ->where([['des_pres','LIKE', '%' . $busqueda . '%'],['estado_pres','=','Activo']]) //busqueda
            ->orderBy('cod_pres','desc')
            ->paginate(7);

        return response()->json([
            "presentaciones" => $presentacion
        ], 200);
    }

    // public function create()
    // {
    //     //NO REQUIERE
    // }

 
    public function store(FormPresentacion $request)
    {
        try{
            DB::beginTransaction();
            $presentacion = new Presentacion();
            $presentacion->des_pres = $request->get('des_pres');
            $presentacion->save();
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
        }
        return response()->json([
            'presentacion' => $presentacion
        ], 200, );
    }

    public function edit($id)
    {
        $presentacion = DB::table('presentacion')
        ->select('cod_pres','des_pres')
        ->where('cod_pres','=',$id)
        ->first();

        return response()->json([
            "presentacion" => $presentacion
        ], 200,);
    }


    public function update(FormPresentacionUpdate $request,$id)
    {
        try{
            DB::beginTransaction();
            $presentacion = Presentacion::find($id);
            $presentacion->des_pres = $request->get('des_pres');
            $presentacion->update();
            DB::commit();

            if($presentacion->update()){
                $msg="Registro presentacion modificado";
            }

        }catch(Exception $e){
            DB::rollBack();
        }
        return response()->json([
            'presentacion' => $presentacion,
            'msg'=>$msg
        ], 200, );
    }


    public function destroy($id)
    {

        try{
            DB::beginTransaction();
            $presentacion = Presentacion::find($id);
            $presentacion->estado_pres = "Inactivo"; // 1:Activo  2:Inactivo
            $presentacion->update();
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'msg' => "Error al deshabilitar registro",
                'error' => $e
            ], 200, ); 
        }
        return response()->json([
            'msg' => "Registro presentacion deshabilitado",
        ], 200, );  

    }

    public function indexDeleted(Request $request)
    {
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }

        $presentacion = DB::table('presentacion')
            ->select('cod_pres','des_pres')
            ->where([['des_pres','LIKE', '%' . $busqueda . '%'],['estado_pres','=','Inactivo']]) //busqueda
            ->orderBy('cod_pres','desc')
            ->paginate(7);

        return response()->json([
            "presentaciones" => $presentacion
        ], 200);
    }

    public function restore($id)
    {

        try{
            DB::beginTransaction();
            $presentacion = Presentacion::find($id);
            $presentacion->estado_pres = "Activo"; // 1:Activo  2:Inactivo
            $presentacion->update();
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'msg' => "Error al habilitar registro",
                'error' => $e
            ], 200, ); 
        }
        return response()->json([
            'msg' => "Registro presentacion habilitado",
        ], 200, );  

    }
}
