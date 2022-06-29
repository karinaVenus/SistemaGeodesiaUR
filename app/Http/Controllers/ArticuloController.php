<?php

namespace App\Http\Controllers;
//modelos
use App\Models\Articulo;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

//restricciones
use App\Http\Requests\FormArticulo;
use App\Http\Requests\FormArticuloUpdate;

use Exception;

class ArticuloController extends Controller
{

    function __construct()
    {
        $this->middleware('permission:ver-articulos|registrar-articulos|editar-articulos|eliminar-articulos')->only(['index','show']);
        $this->middleware('permission:registrar-articulos')->only(['create','store']);
        $this->middleware('permission:editar-articulos')->only(['edit','update']);
        $this->middleware('permission:eliminar-articulos')->only('destroy');
    }

    public function index(Request $request)
    {
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }
        //valida tema imagen
        $articulo = DB::table('articulo as art')
            ->join('categoria as cat','art.cod_cat','=','cat.cod_cat')
            ->join('presentacion as pr','art.cod_pres','=','pr.cod_pres')
            ->join('unid_med as um','art.cod_unid_med','=','um.cod_unid_med')
            ->select('art.cod_art','art.des_art','cat.des_cat','pr.des_pres','um.des_unid_med')
            ->where([['art.cod_art','LIKE', '%' . $busqueda . '%'],['cod_estado_art','=',1]])
            ->orwhere([['art.des_art','LIKE', '%' . $busqueda . '%'],['cod_estado_art','=',1]])
            ->orwhere([['pr.des_pres','LIKE', '%' . $busqueda . '%'],['cod_estado_art','=',1]])
            ->orderBy('art.des_art', 'desc')
            ->paginate(5);

        return response()->json([
            "articulos" => $articulo
        ], 200);
    }

    public function create()
    {
        $categoria = DB::table('categoria')
        ->select('cod_cat','des_cat')
        ->orderBy('cod_cat','asc')
        ->get();

        $presentacion = DB::table('presentacion')
        ->select('cod_pres','des_pres')
        ->orderBy('cod_pres','asc')
        ->get();

        $unid_med = DB::table('unid_med')
        ->select('cod_unid_med','des_unid_med')
        ->orderBy('cod_unid_med','asc')
        ->get();

        return response()->json([
            "categoria"=>$categoria,
            "presentacion"=>$presentacion,
            "unid_med"=>$unid_med
        ], 200,);
    }


    public function store(FormArticulo $request)
    {
        try{
            DB::beginTransaction();
            $articulo = new Articulo;
            $articulo->cod_art = $request->get('cod_art');
            $articulo->des_art = $request->get('des_art');
            $articulo->cod_cat = $request->get('cod_cat');
            $articulo->cod_pres = $request->get('cod_pres');
            $articulo->cod_unid_med = $request->get('cod_unid_med');
            $articulo->imagen_art = $request->get('imagen_art');
            //$articulo->cod_estado_art = 1; // 1:Activo  2:Inactivo
            $articulo->save();

            if($articulo->save()){
                $msg="Articulo registrado";
            }
            DB::commit();

        }catch(Exception $e){
            DB::rollBack();
        }

        return response()->json([
            'msg' => $msg
        ], 200, );
    }

    public function show($id)
    {
        $articulo = DB::table('articulo as art')
        ->join('categoria as cat','art.cod_cat','=','cat.cod_cat')
        ->join('presentacion as pr','art.cod_pres','=','pr.cod_pres')
        ->join('unid_med as um','art.cod_unid_med','=','um.cod_unid_med')
        ->select('art.des_art','cat.des_cat','pr.des_pres','um.des_unid_med','art.imagen_art')
        ->where('art.cod_art','=',$id)
        ->get();

        return response()->json([
            "articulo" => $articulo
        ], 200, );
    }

    public function edit($id)
    {   //consultar y obtener los datos referente al precarcado
        $articulo = DB::table('articulo as art')
        ->select('art.cod_art','art.des_art','art.cod_cat','art.cod_pres','art.cod_unid_med','art.imagen_art')
        ->where('art.cod_art','=',$id)
        ->first();

        $categoria = DB::table('categoria')
        ->select('cod_cat','des_cat')
        ->orderBy('cod_cat','asc')
        ->get();

        $presentacion = DB::table('presentacion')
        ->select('cod_pres','des_pres')
        ->orderBy('cod_pres','asc')
        ->get();

        $unid_med = DB::table('unid_med')
        ->select('cod_unid_med','des_unid_med')
        ->orderBy('cod_unid_med','asc')
        ->get();

        return response()->json([
            "articulo" => $articulo,

            "categoria"=>$categoria,
            "presentacion"=>$presentacion,
            "unid_med"=>$unid_med
        ], 200,);
    }

    public function update(FormArticuloUpdate $request, $id)
    {   // METODO PUT 
        try{
            DB::beginTransaction();
            $articulo = Articulo::find($id);
            $articulo->cod_art = $request->get('cod_art');
            $articulo->des_art = $request->get('des_art');
            $articulo->cod_cat = $request->get('cod_cat');
            $articulo->cod_pres = $request->get('cod_pres');
            $articulo->cod_unid_med = $request->get('cod_unid_med');
            $articulo->imagen_art = $request->get('imagen_art');
            $articulo->update();

            if($articulo->update()){
                $msg="Registro articulo modificado";
            }
            DB::commit();

        }catch(Exception $e){
            DB::rollBack();
        }

        return response()->json([
            'articulo' => $articulo,
            'msg' => $msg
        ], 200, );
    }

    public function destroy($id)
    {
        $articulo = Articulo::find($id);
        $articulo->cod_estado_art = 2; // 1:Activo  2:Inactivo
        $articulo->update();

        if($articulo->update()){
            $msg="Registro articulo deshabilitado";
        }

        return response()->json([
            'msg' => $msg
        ], 200, );
    }
}
