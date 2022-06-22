<?php

namespace App\Http\Controllers;

use App\Http\Requests\FormTipo_Transf;
use App\Http\Requests\FormTipo_TransfUpdate;
use App\Models\Tipo_Transf;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TipoTransfController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:ver-tipos de transferencias|registrar-tipos de transferencias|editar-tipos de transferencias|eliminar-tipos de transferencias')->only(['index','show']);
        $this->middleware('permission:registrar-tipos de transferencias')->only(['create','store']);
        $this->middleware('permission:editar-tipos de transferencias')->only(['edit','update']);
        $this->middleware('permission:eliminar-tipos de transferencias')->only('destroy');
    }

    public function index(Request $request)
    {

        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }

        $tipo_transf = DB::table('tipo_transf')
            ->select('cod_t_transf','des_transf')
            ->where([['des_transf','LIKE', '%'.$busqueda.'%'],['estado_transf','=','Activo']]) 
            ->orderBy('cod_t_transf','desc')
            ->paginate(7);

        return response()->json([
            "tipo_transf" => $tipo_transf
        ], 200);
    }

    // public function create()
    // {
    //     // NO REQUIERE
    // }

    public function store(FormTipo_Transf $request)
    {
        try{
            DB::beginTransaction();
            $tipo_transf = new Tipo_Transf();
            $tipo_transf->des_transf = $request->get('des_transf');
            $tipo_transf->save();
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
        }
        return response()->json([
            'tipo_transf' => $tipo_transf
        ], 200, );
    }

    // public function show($id)
    // {
    //      // NO REQUIERE
    //     $tipo_transf = DB::table('tipo_transf')
    //     ->select('cod_t_transf','des_transf')
    //     ->where('cod_t_transf','=',$id)
    //     ->get();

    //     return response()->json([
    //         "tipo_transf" => $tipo_transf
    //     ], 200,);
    // }

    public function edit($id)
    {
        $tipo_transf = Tipo_Transf::find($id);
        return response()->json([
            "tipo_transf" => $tipo_transf->makeHidden('estado_transf')
        ], 200,);
    }

    public function update(FormTipo_TransfUpdate $request,$id)
    {
        try{
            DB::beginTransaction();
            $tipo_transf = Tipo_Transf::find($id);
            $tipo_transf->des_transf = $request->get('des_transf');
            $tipo_transf->update();

            if($tipo_transf->update()){
                $msg="Registro tipo de transferencia modificado";
            }
            DB::commit();

        }catch(Exception $e){
            DB::rollBack();
        }

        return response()->json([
            'tipo_transf' => $tipo_transf,
            'msg' => $msg
        ], 200, );
    }

    public function destroy($id)
    {
        $tipo_transf = Tipo_Transf::find($id);
        $tipo_transf->estado_transf = "Inactivo"; // 1:Activo  2:Inactivo
        $tipo_transf->update();

        if($tipo_transf->update()){
            $msg="Registro tipo de transferencia deshabilitado";
        }

        return response()->json([
            'msg' => $msg
        ], 200, );
    }
}
