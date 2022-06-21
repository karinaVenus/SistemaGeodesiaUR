<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

//agregamos el modelo de permisos de spatie
use Spatie\Permission\Models\Permission;

class SeederTablaPermisos extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $permisos = [
    	    'ver-articulos',
            'ver-ingresos de insumo',
            'ver-salidas de insumo',
            'ver-proveedores',
            'ver-trabajadores',
            'ver-roles',
            'ver-almacenes',
            'ver-categorias',
            'ver-presentaciones',
            'ver-unidades de medida',
            'ver-tipos de documento',
            'ver-tipos de transferencias',
            'registrar-articulos',
            'registrar-ingresos de insumo',
            'registrar-salidas de insumo',
            'registrar-proveedores',
            'registrar-trabajadores',
            'registrar-roles',
            'registrar-almacenes',
            'registrar-categorias',
            'registrar-presentaciones',
            'registrar-unidades de medida',
            'registrar-tipos de documento',
            'registrar-tipos de transferencias',
            'editar-articulos',
            'editar-ingresos de insumo',
            'editar-salidas de insumo',
            'editar-proveedores',
            'editar-trabajadores',
            'editar-roles',
            'editar-almacenes',
            'editar-categorias',
            'editar-presentaciones',
            'editar-unidades de medida',
            'editar-tipos de documento',
            'editar-tipos de transferencias',
            'eliminar-articulos',
            'eliminar-ingresos de insumo',
            'eliminar-salidas de insumo',
            'eliminar-proveedores',
            'eliminar-trabajadores',
            'eliminar-roles',
            'eliminar-almacenes',
            'eliminar-categorias',
            'eliminar-presentaciones',
            'eliminar-unidades de medida',
            'eliminar-tipos de documento',
            'eliminar-tipos de transferencias',
            'generar-kardex',
            'generar-inventario'
        ];

        foreach($permisos as $permiso) {
            Permission::create(['name'=>$permiso]);
        }
    }
}