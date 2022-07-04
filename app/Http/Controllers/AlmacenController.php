<?php

namespace App\Http\Controllers;


use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Permission;
use App\Models\Almacen;
use App\Http\Requests\FormAlmacen;
use App\Http\Requests\FormAlmacenUpdate;


class AlmacenController extends Controller
{
    
    function __construct()
    {
        $this->middleware('permission:ver-almacenes|registrar-almacenes|editar-almacenes|eliminar-almacenes')->only(['index']);
        $this->middleware('permission:registrar-almacenes')->only(['create','store']);
        $this->middleware('permission:editar-almacenes')->only(['edit','update']);
        $this->middleware('permission:eliminar-almacenes')->only(['destroy','indexDeleted','restore']);
    }

    public function index(Request $request)
    {
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }
        $almacenes = Almacen::where([['cod_estado_almacen','=',1],['des_almacen','like','%'.$busqueda.'%']])
                    ->orderby('cod_estado_almacen','desc')
                    ->paginate(8,['cod_almacen','des_almacen','ubic_almacen']);

        return response()->json([
            "almacenes" => $almacenes
        ], 200);
    }

    public function store(FormAlmacen $request)
    {

        try{
            DB::beginTransaction();
            $almacen = new Almacen();
            $almacen->des_almacen = $request->get('des_almacen');
            $almacen->ubic_almacen = $request->get('ubic_almacen');
            $almacen->save();

            $permiso = Permission::create(['guard_name' => 'web','name' => $almacen->des_almacen]);

            DB::insert('insert into acceso (id,id_almacen) values(?,?)',[$permiso->id,$almacen->cod_almacen]);

            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                "msg" => "error",
                $e
            ],400);
        }

        return response()->json([
            "msg" => "Almacen registrado"
        ],201);

    }

    public function edit($id)
    {
        $almacen = Almacen::where('cod_almacen',$id)
                    ->first(['cod_almacen','des_almacen','ubic_almacen']);

        return response()->json([
            "almacen" => $almacen
        ], 200);

    }

    public function update(FormAlmacenUpdate $request, $id)
    {
        try{
            DB::beginTransaction();
            $des_almacen = $request->get('des_almacen');
            $ubic_almacen = $request->get('ubic_almacen');

            $act_name =  DB::table('almacen')
                        ->select('des_almacen')
                        ->where('cod_almacen',$id)
                        ->first();
           

            DB::table('almacen')
            ->where('cod_almacen', $id) 
            ->limit(1)  
            ->update(array('des_almacen' => $des_almacen ,'ubic_almacen' => $ubic_almacen));

            DB::table('permissions')
            ->where('name','=', $act_name->des_almacen)  
            ->limit(1) 
            ->update(array('name' => $des_almacen));

            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                "msg" => "error",
                "errores" => $e
            ],400);
        }

        return response()->json([
            "msg" => "Almacen Actualizado"
        ],201);
    }

    public function destroy($id)
    {
        
        try{
            DB::beginTransaction();
            // cambiar estado de almacen
            DB::table('almacen')
                ->where('cod_almacen', $id) 
                ->limit(1)  
                ->update(array('cod_estado_almacen' => 2));
            // cambiar estado de acceso a 0
            DB::table('acceso')
                ->where('id_almacen', $id) 
                ->limit(1)  
                ->update(array('estado' => 0));
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'msg' => 'error',
                'error' => $e
            ], 200);
        }
        return response()->json([
            'msg' => 'Alamacen deshabilitado'
        ], 200);
            
    }

    public function indexDeleted(Request $request)
    {
        $busqueda = "";
        if($request){
            $busqueda = trim($request->get('searchText'));
        }
        $almacenes = Almacen::where([['cod_estado_almacen','=',2],['des_almacen','like','%'.$busqueda.'%']])
                    ->orderby('cod_estado_almacen','desc')
                    ->paginate(8,['cod_almacen','des_almacen','ubic_almacen']);

        return response()->json([
            "almacenes" => $almacenes
        ], 200);
    }

    public function restore($id)
    {
        
        try{
            DB::beginTransaction();
            // cambiar estado de almacen
            DB::table('almacen')
                ->where('cod_almacen', $id) 
                ->limit(1)  
                ->update(array('cod_estado_almacen' => 1));
            // cambiar estado de acceso a 0
            DB::table('acceso')
                ->where('id_almacen', $id) 
                ->limit(1)  
                ->update(array('estado' => 1));
            DB::commit();
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'msg' => 'error',
                'error' => $e
            ], 200);
        }
        return response()->json([
            'msg' => 'Alamacen habilitado'
        ], 200);
            
    }
}
