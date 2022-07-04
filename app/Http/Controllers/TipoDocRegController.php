<?php

namespace App\Http\Controllers;

use App\Http\Requests\FormTipo_doc_reg;
use App\Http\Requests\FormTipo_doc_regUpdate;
use App\Models\Tipo_doc_reg;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TipoDocRegController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:ver-tipos de documento|registrar-tipos de documento|editar-tipos de documento|eliminar-tipos de documento')->only(['index']);
        $this->middleware('permission:registrar-tipos de documento')->only(['create','store']);
        $this->middleware('permission:editar-tipos de documento')->only(['edit','update']);
        $this->middleware('permission:eliminar-tipos de documento')->only(['destroy','indexDeleted','restore']);
    }

    public function index(Request $request)
    {
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }

        $tipo_doc_reg = DB::table('tipo_doc_reg')
            ->select('cod_t_doc','tipo_reg_doc','des_t_doc')
            ->where([['tipo_reg_doc','LIKE', '%'.$busqueda.'%'],['estado_t_doc','=',1]]) 
            ->orwhere([['des_t_doc','LIKE', '%'.$busqueda.'%'],['estado_t_doc','=',1]]) 
            ->orderBy('cod_t_doc','desc')
            ->paginate(8);

        return response()->json([
            "tipo_doc_reg" => $tipo_doc_reg
        ], 200);

    }

    public function store(FormTipo_doc_reg $request)
    {
        try{
            DB::beginTransaction();
            $tipo_doc_reg = new Tipo_doc_reg();
            $tipo_doc_reg->tipo_reg_doc = $request->get('tipo_reg_doc');
            $tipo_doc_reg->des_t_doc = $request->get('des_t_doc');
            $tipo_doc_reg->save();
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
        }
        return response()->json([
            'tipo_doc_reg' => $tipo_doc_reg
        ], 200, );
    }

    public function edit($id)
    {
        $tipo_doc_reg = Tipo_doc_reg::find($id);
        return response()->json([
            "tipo_doc_reg" => $tipo_doc_reg->makeHidden('estado_t_doc')
        ], 200,);
    }

    public function update(FormTipo_doc_regUpdate $request, $id)
    {
        try{
            DB::beginTransaction();
            $tipo_doc_reg = Tipo_doc_reg::find($id);
            $tipo_doc_reg->tipo_reg_doc = $request->get('tipo_reg_doc');
            $tipo_doc_reg->des_t_doc = $request->get('des_t_doc');
            $tipo_doc_reg->update();

            if($tipo_doc_reg->update()){
                $msg="Registro tipo de documento modificado";
            }
            DB::commit();

        }catch(Exception $e){
            DB::rollBack();
        }

        return response()->json([
            'tipo_doc_reg' => $tipo_doc_reg,
            'msg' => $msg
        ], 200, );
    }

    public function destroy($id)
    {
        $tipo_doc_reg = Tipo_doc_reg::find($id);
        $tipo_doc_reg->estado_t_doc = 0; // 1:Activo  0:Inactivo
        $tipo_doc_reg->update();

        if($tipo_doc_reg->update()){
            $msg="Registro tipo documento deshabilitado";
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

        $tipo_doc_reg = DB::table('tipo_doc_reg')
            ->select('cod_t_doc','tipo_reg_doc','des_t_doc')
            ->where([['tipo_reg_doc','LIKE', '%'.$busqueda.'%'],['estado_t_doc','=',0]]) 
            ->orwhere([['des_t_doc','LIKE', '%'.$busqueda.'%'],['estado_t_doc','=',0]]) 
            ->orderBy('cod_t_doc','desc')
            ->paginate(8);

        return response()->json([
            "tipo_doc_reg" => $tipo_doc_reg
        ], 200);

    }

    public function restore($id)
    {
        $tipo_doc_reg = Tipo_doc_reg::find($id);
        $tipo_doc_reg->estado_t_doc = 1; // 1:Activo  0:Inactivo
        $tipo_doc_reg->update();

        if($tipo_doc_reg->update()){
            $msg="Registro tipo documento habilitado";
        }

        return response()->json([
            'msg' => $msg
        ], 200, );
    }

}
