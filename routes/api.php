<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });


Route::post('/login','App\Http\Controllers\UsuarioController@login');

Route::group(['middleware'=>["auth:sanctum"]],function(){
//usuario  ********
    Route::get('/logout','App\Http\Controllers\UsuarioController@logout');
    //Route::get('/perfil/{id}','App\Http\Controllers\UsuarioController@profile');
    Route::get('/perfil','App\Http\Controllers\UsuarioController@profile');
    Route::put('/passUpdate/{id}','App\Http\Controllers\UsuarioController@updatePassword');
//articulo
    Route::post('/articulos','App\Http\Controllers\ArticuloController@index');
    Route::get('/articulos/create','App\Http\Controllers\ArticuloController@create');
    Route::post('/articulo','App\Http\Controllers\ArticuloController@store');
    Route::get('/articulo/{id}','App\Http\Controllers\ArticuloController@show');
    Route::get('/articuloEditar/{id}','App\Http\Controllers\ArticuloController@edit');
    Route::put('/articuloUpdate/{id}','App\Http\Controllers\ArticuloController@update');
    Route::put('/articuloDestroy/{id}','App\Http\Controllers\ArticuloController@destroy');
    Route::post('/articulosDeleted','App\Http\Controllers\ArticuloController@indexDeleted');
    Route::put('/articuloRestore/{id}','App\Http\Controllers\ArticuloController@restore');
//almacen  *********
    Route::post('/almacenes','App\Http\Controllers\AlmacenController@index');
    Route::post('/almacen','App\Http\Controllers\AlmacenController@store');
    Route::get('/almacenEditar/{id}','App\Http\Controllers\AlmacenController@edit');
    Route::put('/almacenUpdate/{id}','App\Http\Controllers\AlmacenController@update');
    Route::put('/almacenDestroy/{id}','App\Http\Controllers\AlmacenController@destroy');
    Route::post('/almacenesDeleted','App\Http\Controllers\AlmacenController@indexDeleted');
    Route::put('/almacenRestore/{id}','App\Http\Controllers\AlmacenController@restore');
//Ingreso insumos ******
    Route::post('/registrosIngresos','App\Http\Controllers\RegIngCabController@index');
    Route::get('/registrosIngresos/create','App\Http\Controllers\RegIngCabController@create');
    Route::get('/registroIngreso/trabajador/{id}','App\Http\Controllers\RegIngCabController@trabajador');
    Route::post('/registroIngreso','App\Http\Controllers\RegIngCabController@store');
    Route::get('/registroIngreso/{id}','App\Http\Controllers\RegIngCabController@show');
    Route::get('/registroIngresoEditar/{id}','App\Http\Controllers\RegIngCabController@edit');
    Route::put('/registroIngresoUpdate/{id}','App\Http\Controllers\RegIngCabController@update');
//presentaciones  *******
    Route::post('/presentaciones','App\Http\Controllers\PresentacionController@index');
    Route::post('/presentacion','App\Http\Controllers\PresentacionController@store');//
    Route::get('/presentacionEditar/{id}','App\Http\Controllers\PresentacionController@edit');
    Route::put('/presentacionUpdate/{id}','App\Http\Controllers\PresentacionController@update');
    Route::put('/presentacionDestroy/{id}','App\Http\Controllers\PresentacionController@destroy');
    Route::post('/presentacionesDeleted','App\Http\Controllers\PresentacionController@indexDeleted');
    Route::put('/presentacionRestore/{id}','App\Http\Controllers\PresentacionController@restore');
//categorias  ********
    Route::post('/categorias','App\Http\Controllers\CategoriaController@index');
    Route::post('/categoria','App\Http\Controllers\CategoriaController@store');
    Route::get('/categoriaEditar/{id}','App\Http\Controllers\CategoriaController@edit');
    Route::put('/categoriaUpdate/{id}','App\Http\Controllers\CategoriaController@update');
    Route::put('/categoriaDestroy/{id}','App\Http\Controllers\CategoriaController@destroy');
    Route::post('/categoriasDeleted','App\Http\Controllers\CategoriaController@indexDeleted');
    Route::put('/categoriaRestore/{id}','App\Http\Controllers\CategoriaController@restore');
//unidad medida  ******
    Route::post('/unidadesMedida','App\Http\Controllers\UnidMedController@index');
    Route::post('/unidadMedida','App\Http\Controllers\UnidMedController@store');
    Route::get('/unidadMedidaEditar/{id}','App\Http\Controllers\UnidMedController@edit');
    Route::put('/unidadMedidaUpdate/{id}','App\Http\Controllers\UnidMedController@update');
    Route::put('/unidadMedidaDestroy/{id}','App\Http\Controllers\UnidMedController@destroy');
    Route::post('/unidadesMedidaDeleted','App\Http\Controllers\UnidMedController@indexDeleted');
    Route::put('/unidadMedidaRestore/{id}','App\Http\Controllers\UnidMedController@restore');
//tipo transferencias  *********
    Route::post('/tiposTransferencias','App\Http\Controllers\TipoTransfController@index');
    Route::post('/tipoTransferencia','App\Http\Controllers\TipoTransfController@store');
    Route::get('/tipoTransferenciaEditar/{id}','App\Http\Controllers\TipoTransfController@edit');
    Route::put('/tipoTransferenciaUpdate/{id}','App\Http\Controllers\TipoTransfController@update');
    Route::put('/tipoTransferenciaDestroy/{id}','App\Http\Controllers\TipoTransfController@destroy');
    Route::post('/tiposTransferenciasDeleted','App\Http\Controllers\TipoTransfController@indexDeleted');
    Route::put('/tipoTransferenciaRestore/{id}','App\Http\Controllers\TipoTransfController@restore');
//tipo documento registro  
    Route::post('/tiposDocumentosRegistros','App\Http\Controllers\TipoDocRegController@index');
    Route::post('/tipoDocumentoRegistro','App\Http\Controllers\TipoDocRegController@store');
    Route::get('/tipoDocumentoRegistroEditar/{id}','App\Http\Controllers\TipoDocRegController@edit');
    Route::put('/tipoDocumentoRegistroUpdate/{id}','App\Http\Controllers\TipoDocRegController@update');
    Route::put('/tipoDocumentoDestroy/{id}','App\Http\Controllers\TipoDocRegController@destroy');
    Route::post('/tiposDocumentosRegistrosDeleted','App\Http\Controllers\TipoDocRegController@indexDeleted');
    Route::put('/tipoDocumentoRestore/{id}','App\Http\Controllers\TipoDocRegController@restore');
//salida de insumos  ********
    Route::post('/registrosSalidas','App\Http\Controllers\RegSalCabController@index');
    Route::get('/registrosSalidas/create','App\Http\Controllers\RegSalCabController@create');
    Route::get('/registroSalida/solicita/{id}','App\Http\Controllers\RegSalCabController@trabajadorSolicitante');
    Route::get('/registroSalida/autoriza/{id}','App\Http\Controllers\RegSalCabController@trabajadorAtorizador');
    Route::get('/registroSalida/articulos/{id}','App\Http\Controllers\RegSalCabController@articulos');//articulos
    Route::post('/registroSalida','App\Http\Controllers\RegSalCabController@store');
    Route::get('/registroSalida/{id}','App\Http\Controllers\RegSalCabController@show');
    Route::get('/registroSalidaEditar/{id}','App\Http\Controllers\RegSalCabController@edit');
    Route::put('/registroSalidaUpdate/{id}','App\Http\Controllers\RegSalCabController@update');
//kardex
    Route::get('/kardex','App\Http\Controllers\KardexController@index');
    Route::get('/kardex/articulos/{id}','App\Http\Controllers\KardexController@articulos');
    Route::post('/kardexReporte','App\Http\Controllers\KardexController@kardex');
//inventario
    Route::get('/inventario','App\Http\Controllers\InventarioController@index');
    Route::get('/inventarioReporte/{id}','App\Http\Controllers\InventarioController@inventario');
//trabajador ******
    Route::post('/trabajadores','App\Http\Controllers\TrabajadorController@index');
    Route::get('/trabajador/provincias/{id}','App\Http\Controllers\TrabajadorController@provincias');
    Route::get('/trabajador/distritos/{id}','App\Http\Controllers\TrabajadorController@distritos');
    Route::get('/trabajador/create','App\Http\Controllers\TrabajadorController@create');
    Route::post('/trabajador','App\Http\Controllers\TrabajadorController@store');
    Route::get('/trabajadorAsignar/assing/{id}','App\Http\Controllers\TrabajadorController@asignarRolAcceso');
    Route::post('/trabajadorAsignar/{id}','App\Http\Controllers\TrabajadorController@storeRolAcceso');
    Route::get('/trabajador/{id}','App\Http\Controllers\TrabajadorController@show');
    Route::get('/trabajadorEditar/{id}','App\Http\Controllers\TrabajadorController@edit');
    Route::put('/trabajadorUpdate/{id}','App\Http\Controllers\TrabajadorController@update');
    Route::put('/trabajadorDestroy/{id}','App\Http\Controllers\TrabajadorController@destroy');
    Route::post('/trabajadoresDeleted','App\Http\Controllers\TrabajadorController@indexDeleted');
    Route::put('/trabajadorRestore/{id}','App\Http\Controllers\TrabajadorController@restore');
//proveedor  **********
    Route::post('/proveedores','App\Http\Controllers\ProveedorController@index');    
    Route::get('/proveedor/provincias/{id}','App\Http\Controllers\ProveedorController@provincias');
    Route::get('/proveedor/distritos/{id}','App\Http\Controllers\ProveedorController@distritos');
    Route::get('/proveedor/create','App\Http\Controllers\ProveedorController@create');
    Route::post('/proveedor','App\Http\Controllers\ProveedorController@store');
    Route::get('/proveedor/{id}','App\Http\Controllers\ProveedorController@show');
    Route::get('/proveedorEditar/{id}','App\Http\Controllers\ProveedorController@edit');
    Route::put('/proveedorUpdate/{id}','App\Http\Controllers\ProveedorController@update');
    Route::put('/proveedorDestroy/{id}','App\Http\Controllers\ProveedorController@destroy');
    Route::post('/proveedoresDeleted','App\Http\Controllers\ProveedorController@indexDeleted');
    Route::put('/proveedorRestore/{id}','App\Http\Controllers\ProveedorController@restore');
//rol ******
    Route::post('/roles','App\Http\Controllers\RolController@index');
    Route::get('/roles/create','App\Http\Controllers\RolController@create');
    Route::post('/rol','App\Http\Controllers\RolController@store');
    Route::get('/rolEditar/{id}','App\Http\Controllers\RolController@edit');
    Route::put('/rolUpdate/{id}','App\Http\Controllers\RolController@update');
    Route::delete('/rolDelete/{id}','App\Http\Controllers\RolController@destroy');
//empresa
    Route::get('/empresa','App\Http\Controllers\EmpresaController@show');
    Route::get('/empresaEditar/{id}','App\Http\Controllers\EmpresaController@edit');
    Route::put('/empresaUpdate/{id}','App\Http\Controllers\EmpresaController@update');
});



