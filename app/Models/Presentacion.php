<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Presentacion extends Model
{
    //use HasFactory;
    protected $table = 'presentacion';
    protected $primaryKey = 'cod_pres';
    public $timestamps = false;
 
    protected $fillable = [
         'des_pres'
    ];
 
    protected $guarded = [];
}
