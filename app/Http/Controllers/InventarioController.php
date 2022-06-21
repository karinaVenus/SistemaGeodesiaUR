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
        return response()->json([
            'inventario' => $inventario
        ], 200);
    }

}
