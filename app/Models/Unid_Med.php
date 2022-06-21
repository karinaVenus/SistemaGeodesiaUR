<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Unid_Med extends Model
{
     //use HasFactory;
     protected $table = 'unid_med';
     protected $primaryKey = 'cod_unid_med';
     public $timestamps = false;
  
     protected $fillable = [
          'des_unid_med',
          'prefijo_unid_med'
     ];
  
     protected $guarded = [];
}
