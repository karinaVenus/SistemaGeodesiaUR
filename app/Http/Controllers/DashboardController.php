<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function almacenes()
    {
        $accesos = array();
        $user = auth()->user()->getDirectPermissions();
        foreach($user as $u){
            array_push($accesos, $u->name);
        }
        $almacen = DB::table('almacen')
        ->select('cod_almacen','des_almacen')
        ->where('cod_estado_almacen',1)
        ->wherein('des_almacen',$accesos)
        ->orderBy('des_almacen','asc')
        ->get();

        return response()->json([
            "almacen" => $almacen
        ], 200);
    }

    public function ingresoArticulos($id)
    {
        $articulosIngreso = DB::select("SELECT CONCAT(art.des_art,' / ',pr.des_pres) AS articulo, SUM(rd.cant_art) AS cantidad FROM 
        reg_ing_det AS rd
        INNER JOIN articulo AS art ON art.cod_art = rd.cod_art
        INNER JOIN presentacion AS pr ON pr.cod_pres = art.cod_pres
        INNER JOIN reg_ing_cab AS rc ON rc.cod_reg_in = rd.cod_reg_ing
        WHERE rc.fec_ing BETWEEN DATE_SUB(NOW(), INTERVAL 30 DAY) AND NOW()
        GROUP BY rd.cod_art
        ORDER BY SUM(rd.cant_art) DESC");

        return response()->json([
            "articulosIngreso" => $articulosIngreso
        ], 200);
    }

    public function salidaArticulos($id)
    {
        $articulosSalida = DB::select("SELECT CONCAT(art.des_art,' / ',pr.des_pres) AS articulo, SUM(rd.cant_art) AS cantidad FROM 
        reg_sal_det AS rd
        INNER JOIN articulo AS art ON art.cod_art = rd.cod_art
        INNER JOIN presentacion AS pr ON pr.cod_pres = art.cod_pres
        INNER JOIN reg_sal_cab AS rc ON rc.cod_reg_sal = rd.cod_reg_sal
        WHERE rc.fec_sal BETWEEN DATE_SUB(NOW(), INTERVAL 30 DAY) AND NOW()
        GROUP BY rd.cod_art
        ORDER BY SUM(rd.cant_art) DESC");

        return response()->json([
            "articulosSalida" => $articulosSalida
        ], 200);
    }

    public function usersNow()
    {
        $usuariosOn = DB::select("SELECT COUNT(DISTINCT(p.tokenable_id)) cantidad FROM personal_access_tokens as p
        WHERE (p.last_used_at BETWEEN DATE_SUB(NOW(), INTERVAL 30 MINUTE) AND NOW()) OR 
        (p.created_at BETWEEN DATE_SUB(NOW(), INTERVAL 30 MINUTE) AND NOW())");

        return response()->json([
            "usuariosOn" => $usuariosOn
        ], 200);
    }

}
