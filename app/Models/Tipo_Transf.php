<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tipo_Transf extends Model
{
    //use HasFactory;
    protected $table = 'tipo_transf';
    protected $primaryKey = 'cod_t_transf';
    public $timestamps = false;
 
    protected $fillable = [
         'des_transf'
    ];
 
    protected $guarded = [];
}
