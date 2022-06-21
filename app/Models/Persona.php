<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Persona extends Model
{
    //use HasFactory;
    protected $table = 'persona';
    protected $primaryKey = 'cod_persona';
    public $timestamps = false;
   
    protected $fillable = [
        'cod_t_per',
        'razon_social',
        'nom_per',
        'ape_pat_per',
        'ape_mat_per',
        'cod_t_doc',
        'nro_doc',
        'correo_per',
        'cod_dist',
        'dir_per'
    ];
   
    protected $guarded = [];
}
