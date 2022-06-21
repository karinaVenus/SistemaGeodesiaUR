<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class KardexController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:generar-kardex|generar-kardex')->only(['index','inventario','articulos']);
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

    public function articulos($id)
    {
         $articulos_precargado = DB::table('articulo as art')
        ->join('unid_med as um','art.cod_unid_med','=','um.cod_unid_med')
        ->join('inventario as inv','inv.cod_art','=','art.cod_art')
        ->select(DB::raw("art.cod_art,CONCAT(art.des_art,' | ',um.prefijo_unid_med) as articulo"))
        ->where('cod_almacen','=',$id)
        ->orderBy('art.des_art','asc')//ordenar por nombre
        ->get();

        return response()->json([
            'articulo' => $articulos_precargado,
             ],200);    
    }

    public function kardex(Request $request)
    {
        $articulo = $request->get('articulo');
        $fec_ini = $request->get('fec_ini');
        $fec_fin = $request->get('fec_fin');
        $almacen = $request->get('almacen');
        $kardex = "";$val_net_ini = "";$cant_ini = "";
        
        if($articulo != null && $fec_ini != null && $fec_fin != null && $almacen!=null){
            $val_net_ini = DB::select('call total_valor_lapso(?,?,?)',array($articulo,$fec_ini,$almacen));
            $cant_ini = DB::select('call total_cant_lapso(?,?,?)',array($articulo,$fec_ini,$almacen)); 
            $kardex =  DB::select('call kardex_articulo(?,?,?,?)',array($articulo,$fec_ini,$fec_fin,$almacen));
            // $kardex =  DB::select('call kardex_articulo("art01","2022-05-01","2022-05-31")');
            $msg="kardex obtenido";
        }else $msg="nada que mostrar";

        return response()->json([
            'msg' => $msg,
            'cant_ini' => $cant_ini,
            'val_net_ini' => $val_net_ini,
            'Kardex'=> $kardex,
        ], 200);
    }
}
