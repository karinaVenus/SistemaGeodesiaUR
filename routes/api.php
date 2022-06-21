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

    Route::get('/logout','App\Http\Controllers\UsuarioController@logout');
    Route::get('/perfil/{id}','App\Http\Controllers\UsuarioController@profile');
    Route::post('/passUpdate/{id}','App\Http\Controllers\UsuarioController@updatePassword');

    Route::post('/articulos','App\Http\Controllers\ArticuloController@index');
    Route::get('/articulos/create','App\Http\Controllers\ArticuloController@create');
    Route::post('/articulo','App\Http\Controllers\ArticuloController@store');
    Route::get('/articulo/{id}','App\Http\Controllers\ArticuloController@show');
    Route::get('/articuloEditar/{id}','App\Http\Controllers\ArticuloController@edit');
    Route::put('/articuloUpdate/{id}','App\Http\Controllers\ArticuloController@update');
    Route::put('/articuloDestroy/{id}','App\Http\Controllers\ArticuloController@destroy');

    Route::post('/almacenes','App\Http\Controllers\AlmacenController@index');
    Route::post('/almacen','App\Http\Controllers\AlmacenController@store');
    Route::get('/almacenEditar/{id}','App\Http\Controllers\AlmacenController@edit');
    Route::put('/almacenUpdate/{id}','App\Http\Controllers\AlmacenController@update');

    Route::post('/registrosIngresos','App\Http\Controllers\RegIngCabController@index');
    Route::get('/registrosIngresos/create','App\Http\Controllers\RegIngCabController@create');
    Route::get('/registroIngreso/articulos/{id}','App\Http\Controllers\RegIngCabController@articulos');//articulos
    Route::post('/registroIngreso','App\Http\Controllers\RegIngCabController@store');
    Route::get('/registroIngreso/{id}','App\Http\Controllers\RegIngCabController@show');
    Route::get('/registroIngresoEditar/{id}','App\Http\Controllers\RegIngCabController@edit');
    Route::put('/registroIngresoUpdate/{id}','App\Http\Controllers\RegIngCabController@update');

    Route::post('/presentaciones','App\Http\Controllers\PresentacionController@index');
    Route::post('/presentacion','App\Http\Controllers\PresentacionController@store');//
    Route::get('/presentacion/{id}','App\Http\Controllers\PresentacionController@show');
    Route::get('/presentacionEditar/{id}','App\Http\Controllers\PresentacionController@edit');
    Route::put('/presentacionUpdate/{id}','App\Http\Controllers\PresentacionController@update');
    Route::put('/presentacionDestroy/{id}','App\Http\Controllers\PresentacionController@destroy');

    Route::post('/categorias','App\Http\Controllers\CategoriaController@index');
    Route::post('/categoria','App\Http\Controllers\CategoriaController@store');
    Route::get('/categoria/{id}','App\Http\Controllers\CategoriaController@show');
    Route::get('/categoriaEditar/{id}','App\Http\Controllers\CategoriaController@edit');
    Route::put('/categoriaUpdate/{id}','App\Http\Controllers\CategoriaController@update');
    Route::put('/categoriaDestroy/{id}','App\Http\Controllers\CategoriaController@destroy');

    Route::post('/unidadesMedida','App\Http\Controllers\UnidMedController@index');
    Route::post('/unidadMedida','App\Http\Controllers\UnidMedController@store');
    Route::get('/unidadMedida/{id}','App\Http\Controllers\UnidMedController@show');
    Route::get('/unidadMedidaEditar/{id}','App\Http\Controllers\UnidMedController@edit');
    Route::put('/unidadMedidaUpdate/{id}','App\Http\Controllers\UnidMedController@update');
    Route::put('/unidadMedidaDestroy/{id}','App\Http\Controllers\UnidMedController@destroy');

    Route::post('/tiposTransferencias','App\Http\Controllers\TipoTransfController@index');
    Route::post('/tipoTransferencia','App\Http\Controllers\TipoTransfController@store');
    Route::get('/tipoTransferencia/{id}','App\Http\Controllers\TipoTransfController@show');
    Route::get('/tipoTransferenciaEditar/{id}','App\Http\Controllers\TipoTransfController@edit');
    Route::put('/tipoTransferenciaUpdate/{id}','App\Http\Controllers\TipoTransfController@update');
    Route::put('/tipoTransferenciaDestroy/{id}','App\Http\Controllers\TipoTransfController@destroy');

    Route::post('/tiposDocumentosRegistros','App\Http\Controllers\TipoDocRegController@index');
    Route::post('/tipoDocumentoRegistro','App\Http\Controllers\TipoDocRegController@store');
    Route::get('/tipoDocumentoRegistro/{id}','App\Http\Controllers\TipoDocRegController@show'); //tipo de documento de registro
    Route::get('/tipoDocumentoRegistroEditar/{id}','App\Http\Controllers\TipoDocRegController@edit');
    Route::put('/tipoDocumentoRegistroUpdate/{id}','App\Http\Controllers\TipoDocRegController@update');
    Route::put('/tipoDocumentoDestroy/{id}','App\Http\Controllers\TipoDocRegController@destroy');

    Route::post('/registrosSalidas','App\Http\Controllers\RegSalCabController@index');
    Route::get('/registrosSalidas/create','App\Http\Controllers\RegSalCabController@create');
    Route::get('/registroSalida/articulos/{id}','App\Http\Controllers\RegSalCabController@articulos');//articulos
    Route::post('/registroSalida','App\Http\Controllers\RegSalCabController@store');
    Route::get('/registroSalida/{id}','App\Http\Controllers\RegSalCabController@show');
    Route::get('/registroSalidaEditar/{id}','App\Http\Controllers\RegSalCabController@edit');
    Route::put('/registroSalidaUpdate/{id}','App\Http\Controllers\RegSalCabController@update');

    Route::get('/kardex','App\Http\Controllers\KardexController@index');
    Route::get('/kardex/articulos/{id}','App\Http\Controllers\KardexController@articulos');
    Route::post('/kardexReporte','App\Http\Controllers\KardexController@kardex');

    Route::get('/inventario','App\Http\Controllers\InventarioController@index');
    Route::get('/inventarioReporte/{id}','App\Http\Controllers\InventarioController@inventario');

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

    Route::post('/proveedores','App\Http\Controllers\ProveedorController@index');    
    Route::get('/proveedor/provincias/{id}','App\Http\Controllers\ProveedorController@provincias');
    Route::get('/proveedor/distritos/{id}','App\Http\Controllers\ProveedorController@distritos');
    Route::get('/proveedores/create','App\Http\Controllers\ProveedorController@create');
    Route::post('/proveedor','App\Http\Controllers\ProveedorController@store');
    Route::get('/proveedor/{id}','App\Http\Controllers\ProveedorController@show');
    Route::get('/proveedorEditar/{id}','App\Http\Controllers\ProveedorController@edit');
    Route::put('/proveedorUpdate/{id}','App\Http\Controllers\ProveedorController@update');

    Route::post('/roles','App\Http\Controllers\RolController@index');
    Route::get('/roles/create','App\Http\Controllers\RolController@create');
    Route::post('/rol','App\Http\Controllers\RolController@store');
    Route::get('/rolEditar/{id}','App\Http\Controllers\RolController@edit');
    Route::put('/rolUpdate/{id}','App\Http\Controllers\RolController@update');
});






