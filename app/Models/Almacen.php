<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Almacen extends Model
{
    use HasFactory;

    protected $table = 'almacen';
    public $primaryKey = 'cod_almacen';
    public $timestamps = false;

    protected $fillable = [
        'des_almacen',
        'cod_estado_almacen',
        'ubic_almacen'
    ];

    protected $guarded = [];
}
