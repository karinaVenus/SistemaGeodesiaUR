<?php

namespace App\Http\Controllers;

use App\Http\Requests\FormTrabajador;
use App\Http\Requests\FormAsignarRolAcceso;
use App\Models\User;
use App\Models\Trabajador;
use App\Models\Persona;
use App\Models\Telefono;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use App\Http\Controllers\Controller;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class TrabajadorController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:ver-trabajadores|registrar-trabajadores|editar-trabajadores|eliminar-trabajadores')->only(['index','show']);
        $this->middleware('permission:registrar-trabajadores')->only(['create','store','asignarRolAcceso','storeRolAcceso']);
        $this->middleware('permission:editar-trabajadores')->only(['edit','update','asignarRolAcceso','storeRolAcceso']);
        $this->middleware('permission:eliminar-trabajadores')->only('destroy');
    }

    public function index(Request $request)
    {
        // Listar travbajadores, Nombre, Apellido Mat, Ape Pat, Rol
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }
        $trabajadores = DB::table('persona as per')
            ->rightJoin('trabajador as tr','tr.cod_trabajador','=','per.cod_persona')
            ->join('users as us','us.cod_trabajador','=','tr.cod_trabajador')
            ->leftJoin('model_has_roles as mr','mr.model_id','=','us.id')
            ->leftJoin('roles as r','r.id','=','mr.role_id')
            ->select('tr.cod_trabajador as idTrabajador','per.nom_per as nombre','per.ape_pat_per as ape_paterno',
                    'per.ape_mat_per as ape_materno','r.name as rol')
            ->where([['per.nom_per','LIKE', '%' . $busqueda . '%'],['estado_trab','=',1]])
            ->orwhere('per.ape_pat_per','LIKE','%' . $busqueda . '%')
            ->orwhere('per.ape_pat_per','LIKE','%' . $busqueda . '%')
            ->orderBy('per.nom_per', 'asc')
         ->paginate(15);

        return response()->json([
            "trabajadores" => $trabajadores
        ], 200);

    }

    public function provincias($id)
    {
        $provincia = DB::table('provincia as provi') 
        ->join('departamento as dpt','provi.cod_dep','=','dpt.cod_dpt')
        ->select('provi.cod_provi','provi.des_provi')
        ->where('provi.cod_dep','=',$id)
        ->orderBy('provi.cod_provi','asc')
        ->get();
        return response()->json([
            "provincias"=>$provincia
        ], 200,);
    }

    public function distritos($id)
    {
        $distrito = DB::table('distrito as dist') 
        ->join('provincia as provi','dist.cod_provi','=','provi.cod_provi')
        ->select('dist.cod_dist','dist.des_distrito')
        ->where('dist.cod_provi','=',$id)
        ->orderBy('dist.cod_dist','asc')
        ->get();
        return response()->json([
            "distritos"=>$distrito
        ], 200,);
    }

    public function create()
    {
        $tdoc_ide = DB::table('tdoc_ide') 
        ->select('cod_t_doc','dest_doc')
        ->orderBy('cod_t_doc','asc')
        ->get();

        $departamento = DB::table('departamento') 
        ->select('cod_dpt','des_dpt')
        ->orderBy('cod_dpt','asc')
        ->get();

        $tipo_persona = DB::table('tipo_persona') 
        ->select('cod_t_per','des_t_per')
        ->orderBy('cod_t_per','asc')
        ->get();

        return response()->json([
            "tdoc_ide" => $tdoc_ide,
            "departamento" => $departamento,
            "tipo_persona" => $tipo_persona
        ], 200,);
    }

    public function store(FormTrabajador $request)
    {
        try{
            DB::beginTransaction();
            $trabajador = new Persona();
            $trabajador->cod_t_per = $request->get('cod_t_per');
            $trabajador->nom_per = $request->get('nom_per');
            $trabajador->ape_pat_per = $request->get('ape_pat_per');
            $trabajador->ape_mat_per = $request->get('ape_mat_per');
            $trabajador->cod_t_doc = $request->get('cod_t_doc');
            $trabajador->nro_doc = $request->get('nro_doc');
            $trabajador->correo_per = $request->get('correo_per');
            $trabajador->cod_dist = $request->get('cod_dist');
            $trabajador->dir_per = $request->get('dir_per');
            $trabajador->save();

            $tbl_trabajador = new Trabajador();
            $tbl_trabajador->cod_trabajador =  $trabajador->cod_persona;
            $tbl_trabajador->save();

            $nro_telf = $request->get('nro_telf');
            
            $cont=0;
            
            while($cont < count($nro_telf)){
                $telefono = new Telefono();
                $telefono->cod_persona = $trabajador->cod_persona;

                $telefono->nro_telf=$nro_telf[$cont];
    
                $telefono->save();
    
                $cont = $cont + 1;
            
            }

    //      //extraer caracteres y concatenar con el DNI
             $userPass = strtoupper($request->get('nom_per')[0]).strtoupper($request->get('ape_pat_per')[0]).strtoupper($request->get('ape_mat_per')[0]).$request->get('nro_doc');
    // //      //registrar usuario, asociando el trabajador
             $user = new User();
             $user->cod_trabajador = $tbl_trabajador->cod_trabajador;
             $user->usuario = $userPass;
             $user->contraseña = Hash::make($userPass);
             $user->save();

            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'msg' => "Error",
                'error' => $e,
                'trabajador' => $trabajador,
                'trabajador id' => $trabajador->cod_persona,
                'user' => $user->cod_trabajador
            ]);
        }
        return response()->json([
            'msg' => "Trabajador registrado"
        ]);
    }

    public function asignarRolAcceso($id)
    {
        
        $persona = Persona::find($id);
        $user = User::where('cod_trabajador',$persona->cod_persona)->first();

        $rol = $user->roles;
        $acceso = $user->permissions;

        $roles = Role::all(['id','name'])->toArray();
        $accesos = DB::table('permissions as p')
        ->join('acceso as a','a.id','=','p.id')
        ->select('p.id','name')
        ->get();


        return response()->json([
            'trabajador' => $persona->makeHidden(['cod_persona','cod_t_per','razon_social','cod_t_doc','nro_doc','correo_per','cod_dist','dir_per']),
            'usuario' => $user->makeHidden(['cod_trabajador','contraseña','cod_estado_usu','roles','permissions']),
            'rol-usuario' => $rol->makeHidden(['guard_name','created_at','updated_at','pivot']),
            'acceso-usuario' => $acceso->makeHidden(['guard_name','created_at','updated_at','pivot']),
            'roles' => $roles,
            'accesos' => $accesos
        ], 200); 
    }

    public function storeRolAcceso(FormAsignarRolAcceso $request, $id)
    {
        //
        // Eliminar permisos, luego asignar
        //
        $user = User::find($id);

        DB::table('model_has_roles')->where('model_id',$id)->delete();
        $user->assignRole($request->input('rol'));

        DB::table('model_has_permissions')->where('model_id',$id)->delete();
        $permisos = $request->get('acceso');
        foreach($permisos as $p){
            $user->givePermissionTo($p);
        }

        return response()->json([
            'status' => 'Rol y Accesos asignados existosamente'
        ], 200); 
    }

    public function show($id)
    {
        // OBTENER TODOS LOS DATOS DEL TRABAJADOR
        $trabajador = DB::table('persona as per')
                    ->join('trabajador as t','t.cod_trabajador','=','per.cod_persona')
                    ->join('distrito as d','d.cod_dist','=','per.cod_dist')
                    ->join('provincia as p','d.cod_provi','=','d.cod_provi')
                    ->join('departamento as de','de.cod_dpt','=','p.cod_dep')
                    ->join('tipo_persona as tp','tp.cod_t_per','=','per.cod_t_per')
                    ->join('tdoc_ide as ti','ti.cod_t_doc','=','per.cod_t_doc')
                    ->select('per.cod_persona','tp.des_t_per','per.nom_per','per.ape_pat_per','per.ape_mat_per','ti.dest_doc','per.nro_doc','per.correo_per','de.des_dpt','p.des_provi','d.des_distrito')
                    ->where('cod_persona',$id)
                    ->first();
        $telefono = DB::table('persona as pep')
                    ->join('trabajador as t','t.cod_trabajador','=','pep.cod_persona')
                    ->join('telefono as telf','pep.cod_persona','=','telf.cod_persona')
                    ->select('telf.nro_telf')
                    ->where('pep.cod_persona','=',$id)
                    ->get();
// $trabajador = Persona::find($id);
        return response()->json([
            'trabajador' => $trabajador,
            'telefono' => $telefono
        ], 200);
    }

    public function edit($id)
    {
        // OBTENER TODOS LOS DATOS DEL TRABAJADOR
        $trabajador = DB::table('persona as per')
                ->join('trabajador as t','t.cod_trabajador','=','per.cod_persona')
                ->join('distrito as d','d.cod_dist','=','per.cod_dist')
                ->join('provincia as p','d.cod_provi','=','d.cod_provi')
                ->join('departamento as de','de.cod_dpt','=','p.cod_dep')
                ->select('per.cod_persona','per.cod_t_per','per.nom_per','per.ape_pat_per','per.ape_mat_per','per.cod_t_doc','per.nro_doc','per.correo_per','de.cod_dpt','p.cod_provi','d.cod_dist')
                ->where('cod_persona',$id)
                ->first();
        $telefono = DB::table('persona as pep')
                ->join('trabajador as t','t.cod_trabajador','=','pep.cod_persona')
                ->join('telefono as telf','pep.cod_persona','=','telf.cod_persona')
                ->select('telf.nro_telf')
                ->where('pep.cod_persona','=',$id)
                ->get();

        $tdoc_ide = DB::table('tdoc_ide') 
                ->select('cod_t_doc','dest_doc')
                ->orderBy('cod_t_doc','asc')
                ->get();

        $departamento = DB::table('departamento') 
                ->select('cod_dpt','des_dpt')
                ->orderBy('cod_dpt','asc')
                ->get();

        $tipo_persona = DB::table('tipo_persona') 
                ->select('cod_t_per','des_t_per')
                ->orderBy('cod_t_per','asc')
                ->get();

        return response()->json([
            'trabajador' => $trabajador,
            'telefono' => $telefono,

            "tdoc_ide" => $tdoc_ide,
            "departamento" => $departamento,
            "tipo_persona" => $tipo_persona
        ], 200,);
    }

    public function update(Request $request, $id)
    {
        try{
            DB::beginTransaction();
            $trabajador = Persona::find($id);
            $trabajador->cod_t_per = $request->get('cod_t_per');
            $trabajador->nom_per = $request->get('nom_per');
            $trabajador->ape_pat_per = $request->get('ape_pat_per');
            $trabajador->ape_mat_per = $request->get('ape_mat_per');
            $trabajador->cod_t_doc = $request->get('cod_t_doc');
            $trabajador->nro_doc = $request->get('nro_doc');
            $trabajador->correo_per = $request->get('correo_per');
            $trabajador->cod_dist = $request->get('cod_dist');
            $trabajador->dir_per = $request->get('dir_per');
            $trabajador->save();

            $nro_telf = $request->get('nro_telf');
            DB::delete('delete from telefono where cod_persona = ?',[$id]);            
            $cont=0;
            
            while($cont < count($nro_telf)){
                $telefono = new Telefono();
                $telefono->cod_persona = $id;
                $telefono->nro_telf=$nro_telf[$cont];
                $telefono->save();
    
                $cont = $cont + 1;
            
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
            'msg' => "Trabajador registrado"
        ]);
    }

    public function destroy($id)
    {
        //
    }
}
