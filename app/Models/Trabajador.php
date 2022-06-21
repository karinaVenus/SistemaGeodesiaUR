<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Trabajador extends Model
{
    use HasFactory;
    protected $table = 'trabajador';
    public $timestamps = false;
 
    protected $fillable = [
        'cod_trabajador',
        'estado_trab'
    ];
 
    protected $guarded = [];
}
