<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Articulo extends Model
{
    //use HasFactory;
    protected $table = 'articulo';
    public $primaryKey = 'cod_art';
    public $timestamps = false;
    public $incrementing = false;

    protected $fillable = [
        'cod_art',
        'des_art',
        'cod_cat',
        'cod_pres',
        'cod_unid_med',
        'stock_art',
        'imagen_art',
        'cod_estado_art'
    ];

    protected $guarded = [];
}
