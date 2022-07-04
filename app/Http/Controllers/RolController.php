<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests\FormRol;
use App\Http\Requests\FormRolUpdate;
use App\Http\Controllers\Controller;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Illuminate\Support\Facades\DB;
use Exception;

class RolController extends Controller
{

    function __construct()
    {
        $this->middleware('permission:ver-roles|registrar-roles|editar-roles|eliminar-roles')->only(['index','show']);
        $this->middleware('permission:registrar-roles')->only(['create','store']);
        $this->middleware('permission:editar-roles')->only(['edit','update']);
        $this->middleware('permission:eliminar-roles')->only('destroy');
    }

    public function index(Request $request)
    {
        // NO MOSTRAR EL ADMINISTRADOR
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }

        $roles = Role::where('name','like','%'.$busqueda.'%')
            ->where('name','!=','ADMINISTRADOR')
            ->paginate(8,['id','name']);

        return response()->json([
            "roles" => $roles
        ], 200);
    }

    public function create()
    {
        $permiso = DB::table('permissions as p')
        ->leftjoin('acceso as a','a.id','=','p.id')
        ->select('p.id','p.name')
        ->whereNotIn('p.id',array(DB::raw("(select ac.id from acceso as ac)")))
        ->orderby('p.id','asc')
        ->get();

        return response()->json([
            "permiso" => $permiso//->makeHidden(['created_at','updated_at','guard_name'])
        ], 200);
    }

    public function store(FormRol $request)
    {

        $role = Role::create(['guard_name' => 'web','name' => $request->input('name')]);
        $role->syncPermissions($request->input('permiso'));

        $id_rol = $role->id;

        if($request->get('autorizar') == 1){
            DB::insert('insert into autorizar (id) values(?)',[$id_rol]);
        }

        return response()->json([
            "msg" => 'Rol registrado'
        ], 200);

    }

    public function edit($id)
    {
        // DATOS DEL ROL PARA COMPARAR
        $rol = Role::where([['id',$id],['name','!=','ADMINISTRADOR']])->first();
        if($rol == null){
            return response()->json([
                "mensaje" => "Error al obtener rol"
            ], 400);
        }
        $rol->makeHidden(["guard_name","created_at","updated_at"]);
        $permisosRol = $rol->permissions()->get()->makeHidden(["guard_name","created_at","updated_at","pivot"]);

        $autorizar_val = DB::table('roles as r')
                    ->join('autorizar as a','a.id','r.id')
                    ->where('r.id',$id)
                    ->first();
        $autorizar = 0;
        if($autorizar_val != null){
            $autorizar = 1;
        }

        // Permisos precargados para LLENAR con los datos comparados
        $permisos = DB::table('permissions as p')
        ->leftjoin('acceso as a','a.id','=','p.id')
        ->select('p.id','p.name')
        ->whereNotIn('p.id',array(DB::raw("(select ac.id from acceso as ac)")))
        ->orderby('p.id','asc')
        ->get();
        //

        return response()->json([
            "rol" => $rol,
            "permisos_rol" => $permisosRol,
            "autorizar" => $autorizar,
            "permisos" => $permisos
        ], 200);
    }

    public function update(FormRolUpdate $request, $id)
    {
        // SI La AUTORIZACION = 0, eliminar AUTORIZACION relacionado al rol
        // Si la autorizacion = 1, registrar AUTORIZACION
        //Eliminar todos los permisos
        // Registrar todos los permisos
        //$rol = Role::find($id)->first();
        

        try{
            DB::beginTransaction();

            Role::where('id', $id)->update(['name' => $request->input('name')]);
    
            DB::table('role_has_permissions')->where('role_id',$id)->delete();

            $rol = Role::where([['id',$id],['name','!=','ADMINISTRADOR']])->first();
            if($rol == null){
                return response()->json([
                    "mensaje" => "Error al obtener rol"
                ], 400);
            }
            
            $rol->syncPermissions($request->input('permiso'));
    
            DB::table('autorizar')->where('id', $id)->delete();
            if($request->get('autorizar') == 1){
                DB::insert('insert into autorizar (id) values(?)',[$id]);
            }
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'msg' => "Error",
                'error' => $e
            ]);
        }
        return response()->json([
            "msg" => "Rol actualizado",
        ], 200);
    }

    public function destroy($id)
    {
        // VALIDAR QUE NO SE BORRE ADMINISTRADOR
        //DELETE ROL
        DB::table('role_has_permissions')->where('role_id',$id)->delete();
        DB::table('model_has_roles')->where('role_id',$id)->delete();
        DB::table('autorizar')->where('id', $id)->delete();
        DB::table('roles')->where('id', $id)->delete();
        
        return response()->json([
            "msg" => "Rol eliminado correctamente"
        ], 200);
    }
}
