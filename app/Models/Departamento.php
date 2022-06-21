<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Departamento extends Model
{
     //use HasFactory;
     protected $table = 'departamento';
     protected $primaryKey = 'cod_dpt';
     public $timestamps = false;
  
     protected $fillable = [
          'des_dpt'
     ];
  
     protected $guarded = [];
}
