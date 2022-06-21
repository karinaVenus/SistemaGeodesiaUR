<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Provincia extends Model
{
     //use HasFactory;
     protected $table = 'provincia';
     protected $primaryKey = 'cod_provi';
     public $timestamps = false;
  
     protected $fillable = [
          'des_provi'
     ];
  
     protected $guarded = [];
}
