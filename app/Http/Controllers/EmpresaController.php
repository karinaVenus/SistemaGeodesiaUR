<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;
use App\Http\Requests\FormEmpresaUpdate;
use App\Models\Persona;
use Exception;

class EmpresaController extends Controller
{
    
    public function show()
    {
        $empresa = DB::table('empresa as emp')
                    ->join('persona as p','p.cod_persona','emp.cod_emp')
                    ->join('tipo_persona as tp','p.cod_t_per','=','tp.cod_t_per')
                    ->join('tdoc_ide as tdi','p.cod_t_doc','=','tdi.cod_t_doc')  
                    ->select('emp.cod_emp','emp.logo','tp.des_t_per','p.razon_social','tdi.dest_doc','p.nro_doc','p.correo_per')
                    ->first();
        return response()->json([
            "empresa" => $empresa
        ], 200);
        
    }

    public function edit($id)
    {
        $empresa = DB::table('empresa as emp')
        ->join('persona as p','p.cod_persona','emp.cod_emp')
        ->select('emp.cod_emp','emp.logo','p.cod_t_per','p.razon_social','p.cod_t_doc','p.nro_doc','p.correo_per')
        ->where('emp.cod_emp',$id)
        ->first();

        $tdoc_ide = DB::table('tdoc_ide') 
        ->select('cod_t_doc','dest_doc')
        ->orderBy('cod_t_doc','asc')
        ->get();
        $tipo_persona = DB::table('tipo_persona') 
        ->select('cod_t_per','des_t_per')
        ->orderBy('cod_t_per','asc')
        ->get();

        return response()->json([
        "empresa" => $empresa,
        "tdoc_ide"=>$tdoc_ide,
        "tipo_persona"=>$tipo_persona
        ], 200);
    }

    public function update(FormEmpresaUpdate $request,$id)
    {
        try{
            DB::beginTransaction();
            $empresa = Persona::find($id);
            $empresa->cod_t_per = $request->get('cod_t_per');
            $empresa->razon_social = $request->get('razon_social');
            $empresa->cod_t_doc = $request->get('cod_t_doc');
            $empresa->nro_doc = $request->get('nro_doc');
            $empresa->correo_per = $request->get('correo_per');
            $empresa->update();

            DB::table('empresa')
              ->where('cod_emp', $empresa->cod_persona)
              ->update(['logo' => $request->logo]);
            
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'msg' => "Error",
                "Error" => $e
            ]);
        }
        return response()->json([
            'msg' =>"Datos de empresa actualizados correctamente"
        ]);
    }
}