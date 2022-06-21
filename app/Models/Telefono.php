<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Telefono extends Model
{
    //use HasFactory;
    protected $table = 'telefono';
    protected $primaryKey = 'cod_telf';
    public $timestamps = false;
   
    protected $fillable = [
        'nro_telf',
        'cod_persona'
    ];
   
    protected $guarded = [];
}
