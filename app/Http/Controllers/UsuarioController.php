<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Http\Requests\FormLogin;
use App\Http\Requests\FormChangePass;

use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

use Illuminate\Support\Facades\DB;

class UsuarioController extends Controller
{
    public function login (FormLogin $request)
    {
        $user = User::where([["usuario","=",$request->usuario],['cod_estado_usu','=',1]])->first();

        if( isset($user->id) && $user->cod_estado_usu == 1 ){
            if( Hash::check($request->contraseña,$user->contraseña) ){
                //creamos toke
                $token = $user->createToken("auth_token")->plainTextToken;

                    $rol = $user->roles->pluck('name');
                    $role = Role::where('name',$rol)->first();
                    $permisos = $role->permissions()->get();

                    $persona = DB::table('persona')
                                ->where('cod_persona',$user->cod_trabajador)
                                ->select('nom_per','ape_pat_per','ape_mat_per')
                                ->first();
                    if($persona == null){
                        $persona = "Usuario Maestro"; 
                    }
                return response()->json([
                    "status" => 0,
                    "msg" => "Usuario logeado",
                    "access_token" =>  $token,
                    "nombre" => $persona,
                    "role" => $role->name,
                    "permisos" => $permisos->makeHidden(['id','pivot','updated_at','created_at','guard_name']),
                    "id_usuario" => $user->cod_trabajador
                ],201);
            }else{
                return response()->json([
                    "status" => 0,
                    "msg" => "La contraseña es incorrecta",
                ],404);
            }
        }else{
            return response()->json([
                "status" => 0,
                "msg" => "Usuario no registrado"
            ],404);
        }
    }

    public function logout ()
    {
        auth()->user()->tokens()->delete();

        return response()->json([
            "status" => 0,
            "msg" => "sesion cerrada",
        ]);
    }

    public function profile($id)
    {
        $trabajador = auth()->user()->cod_trabajador;
        $id_user = auth()->user()->id;
        $perfil = DB::table('persona as p')
                ->join('trabajador as t','t.cod_trabajador','=','p.cod_persona')
                ->join('users as u','u.cod_trabajador','=','t.cod_trabajador')
                ->join('tdoc_ide as tdi','p.cod_t_doc','=','tdi.cod_t_doc')
                ->join('distrito as dist','p.cod_dist','=','dist.cod_dist')
                ->join('provincia as provi','dist.cod_provi','=','provi.cod_provi')
                ->join('departamento as dpt','provi.cod_dep','=','dpt.cod_dpt')
                ->select('u.id as usuario','p.nom_per','p.ape_pat_per','p.ape_mat_per','tdi.dest_doc',
                        'p.nro_doc','p.correo_per','dpt.des_dpt','provi.des_provi','dist.des_distrito','p.dir_per')
                ->where('p.cod_persona','=',$id)
                ->where('t.cod_trabajador',$trabajador)
                ->first();

        if($perfil == null){
            return response()->json([
                "msg" => "Error al obtener perfil"
            ]);
        }

        return response()->json([
            "perfil" => $perfil,
            "id_usuario" => $id_user
        ]);

    }

    // public function editPassword()
    // {

    // }    
    
    public function updatePassword(FormChangePass $request,$id)
    {
        $id_confirm = auth()->user()->cod_trabajador;
        if($id_confirm == $id){
            $contra = Hash::make($request->get('password')) ;

            DB::table('users')
            ->where('cod_trabajador', $id)
            ->limit(1) 
            ->update(array('contraseña' => $contra));

            return response()->json([
                "msg" => "Contraseña actualizada",
                "x" =>$id_confirm
            ], 200);
        }else{
            return response()->json([
                "msg" => "Error al actualizar",
                "x" =>$id_confirm
            ], 200);
        }
    }
}
