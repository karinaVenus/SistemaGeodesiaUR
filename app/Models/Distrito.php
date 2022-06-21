<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Distrito extends Model
{
     //use HasFactory;
     protected $table = 'distrito';
     protected $primaryKey = 'cod_dist';
     public $timestamps = false;
  
     protected $fillable = [
          'des_distrito'
     ];
  
     protected $guarded = [];
}
