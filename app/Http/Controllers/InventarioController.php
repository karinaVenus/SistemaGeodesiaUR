<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class InventarioController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:generar-inventario|generar-kardex')->only(['index','inventario']);
    }

    public function index()
    {

        $accesos = "";
        $user = auth()->user()->getDirectPermissions();
        $cont = 0;
        foreach($user as $u){
            if($cont == 0){
                $accesos = "'".$u->name."'";
            }else{
                $accesos = $accesos . " , '" .$u->name."'";
            }
            $cont ++;
        }
        //
        $almacen_precargado = DB::select('SELECT cod_almacen,des_almacen FROM almacen 
                                            WHERE des_almacen IN  ('.$accesos.')
                                            ORDER BY des_almacen asc ');

        return response()->json([
            'almacen' => $almacen_precargado,
        ], 200);
    }

    public function inventario($id){

        $inventario = DB::select('call inventario_actual(?)',array($id));


        // -------- ENVIAR -------------
        // ALMACEN
        $almacen_nom = DB::table('almacen')
                        ->where('cod_almacen',$id)
                        ->select('des_almacen')
                        ->first();
        // NOMBRE USUARIO
        $user = auth()->user()->cod_proveedor;
        $nom_trab = "";
        $trabajador = DB::table('persona')
                        ->where('cod_persona',$user)
                        ->select(DB::raw("CONCAT(nom_per,' ',ape_pat_per,' ',ape_mat_per) as nombre"))
                        ->first();
        if($trabajador == null){
            $nom_trab = "Administrador Master";
        }else{
            $nom_trab = $trabajador->name;
        }
        // NOMBRE EMPRESA
        $empresa = DB::table('empresa as emp')
        ->join('persona as p','p.cod_persona','emp.cod_emp')
        ->select('p.razon_social')
        ->first();
        
        date_default_timezone_set('America/Lima');
        return response()->json([
            'nom_trabajador' => $nom_trab ,
            'fec_generado' => date('d-m-y h:i:s'),
            'almacen' => $almacen_nom->des_almacen,
            'empresa' => $empresa->razon_social,

            'inventario' => $inventario,
        ], 200);
    }


}
