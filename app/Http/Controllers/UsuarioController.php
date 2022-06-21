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
        $user = User::where("usuario","=",$request->usuario)->first();

        if( isset($user->id) ){
            if( Hash::check($request->contraseña,$user->contraseña) ){
                //creamos toke
                $token = $user->createToken("auth_token")->plainTextToken;
                //si todo esta OK

                ///////borrar
                    $rol = $user->roles->pluck('name');
                    $role = Role::where('name',$rol)->first();
                    $permisos = $role->permissions()->get();
                    // $permisos = $user->getRoleNames();
                    //  foreach($permisos as $p){
                    //     $xxx = $p->get('name')->toArray();
                    //     //$p->makeHidden(['id'.'guard_name','created_at','updated_at','pivot']);
                    //  }
                //////////
                return response()->json([
                    "status" => 0,
                    "msg" => "Usuario logeado",
                    "access_token" =>  $token,
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
        // $user = auth()->user();
        // $permisos = $user->getPermissionsViaRoles();
        // $acceso = $user->getDirectPermissions();

        return response()->json([
            "status" => 0,
            "msg" => "sesion cerrada",
            // "usuario" => $user,
            // "permisos" => $permisos,
            // "acceso" =>$acceso
        ]);
    }

    public function profile($id)
    {
        $perfil = DB::table('persona as p')
                ->join('trabajador as t','t.cod_trabajador','=','p.cod_persona')
                ->join('users as u','u.cod_trabajador','=','t.cod_trabajador')
                ->join('tipo_persona as tp','p.cod_t_per','=','tp.cod_t_per')
                ->join('tdoc_ide as tdi','p.cod_t_doc','=','tdi.cod_t_doc')
                ->join('distrito as dist','p.cod_dist','=','dist.cod_dist')
                ->join('provincia as provi','dist.cod_provi','=','provi.cod_provi')
                ->join('departamento as dpt','provi.cod_dep','=','dpt.cod_dpt')
                ->select('u.id as usuario','tp.des_t_per','p.nom_per','p.ape_pat_per','p.ape_mat_per','tdi.dest_doc',
                        'p.nro_doc','p.correo_per','dpt.des_dpt','provi.des_provi','dist.des_distrito','p.dir_per')
                ->where('p.cod_persona','=',$id)
                ->first();

        return response()->json([
            "perfil" => $perfil
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
