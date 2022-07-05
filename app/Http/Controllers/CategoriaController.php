<?php

namespace App\Http\Controllers;

use App\Http\Requests\FormCategoria;
use App\Http\Requests\FormCategoriaUpdate;
use App\Models\Categoria;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CategoriaController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:ver-categorias|registrar-categorias|editar-categorias|eliminar-categorias')->only(['index']);
        $this->middleware('permission:registrar-categorias')->only(['create','store']);
        $this->middleware('permission:editar-categorias')->only(['edit','update']);
        $this->middleware('permission:eliminar-categorias')->only(['destroy','indexDeleted','restore']);
    }

    public function index(Request $request)
    {
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }

        $categoria = DB::table('categoria')
        ->select('cod_cat','des_cat')
        ->where([['des_cat','LIKE', '%' . $busqueda . '%'],['estado_cat','=','Activo']]) 
        ->orderBy('cod_cat','desc')
        ->get();
        $data = array('data' => $categoria);
        return response()->json([
            "categorias" => $data
        ], 200);
        
    }

    public function store(FormCategoria $request)
    {
        try{
            DB::beginTransaction();
            $categoria = new Categoria();
            $categoria->des_cat = $request->get('des_cat');
            $categoria->save();
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
        }
        return response()->json([
            'categoria' => $categoria
        ], 200, );
    }

    public function edit($id)
    {
        $categoria = DB::table('categoria')
        ->select('cod_cat','des_cat')
        ->where('cod_cat','=',$id)
        ->first();

        return response()->json([
            "categoria" => $categoria
        ], 200,);
    }

    public function update(FormCategoriaUpdate $request, $id)
    {
        try{
            DB::beginTransaction();
            $categoria = Categoria::find($id);
            $categoria->des_cat = $request->get('des_cat');
            $categoria->update();
            DB::commit();

            if($categoria->update()){
                $msg="Registro categoria modificado";
            }

        }catch(Exception $e){
            DB::rollBack();
        }
        return response()->json([
            'categoria' => $categoria,
            'msg'=>$msg
        ], 200, );
    }

    public function destroy($id)
    {
        $categoria = Categoria::find($id);
        $categoria->estado_cat = "Inactivo"; // 1:Activo  2:Inactivo
        $categoria->update();

        if($categoria->update()){
            $msg="Registro categoria deshabilitado";
        }

        return response()->json([
            'msg' => $msg
        ], 200, );
    }

    public function indexDeleted(Request $request)
    {
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }

        $categoria = DB::table('categoria')
        ->select('cod_cat','des_cat')
        ->where([['des_cat','LIKE', '%' . $busqueda . '%'],['estado_cat','=','Inactivo']]) 
        ->orderBy('cod_cat','desc')
        ->get();
        $data = array('data' => $categoria);
        return response()->json([
            "categorias" => $data
        ], 200);
        
    }

    public function restore($id)
    {
        $categoria = Categoria::find($id);
        $categoria->estado_cat = "Activo"; // 1:Activo  2:Inactivo
        $categoria->update();

        if($categoria->update()){
            $msg="Registro categoria habilitado";
        }

        return response()->json([
            'msg' => $msg
        ], 200, );
    }
}
