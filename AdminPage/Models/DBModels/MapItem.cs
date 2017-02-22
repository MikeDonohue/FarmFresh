﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace AdminPage.Models.DBModels
{
    [Table("MapItems")]
    public class MapItem
    {
        [Key]
        public int Id { get; set; }
        public string Type { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int Long { get; set; }
        public int Lat { get; set; }
        public bool Active { get; set; }
    }
}