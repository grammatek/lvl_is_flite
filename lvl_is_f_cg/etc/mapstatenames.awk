BEGIN { 
statenamemap[1] = 1;
statename[1] = "C";
statenamemap[2] = 2;
statename[2] = "C";
statenamemap[3] = 3;
statename[3] = "C";
statenamemap[6] = 1;
statename[6] = "D";
statenamemap[7] = 2;
statename[7] = "D";
statenamemap[8] = 3;
statename[8] = "D";
statenamemap[11] = 1;
statename[11] = "E";
statenamemap[12] = 2;
statename[12] = "E";
statenamemap[13] = 3;
statename[13] = "E";
statenamemap[16] = 1;
statename[16] = "EE";
statenamemap[17] = 2;
statename[17] = "EE";
statenamemap[18] = 3;
statename[18] = "EE";
statenamemap[21] = 1;
statename[21] = "G";
statenamemap[22] = 2;
statename[22] = "G";
statenamemap[23] = 3;
statename[23] = "G";
statenamemap[26] = 1;
statename[26] = "I";
statenamemap[27] = 2;
statename[27] = "I";
statenamemap[28] = 3;
statename[28] = "I";
statenamemap[31] = 1;
statename[31] = "II";
statenamemap[32] = 2;
statename[32] = "II";
statenamemap[33] = 3;
statename[33] = "II";
statenamemap[36] = 1;
statename[36] = "J";
statenamemap[37] = 2;
statename[37] = "J";
statenamemap[38] = 3;
statename[38] = "J";
statenamemap[41] = 1;
statename[41] = "Jz";
statenamemap[42] = 2;
statename[42] = "Jz";
statenamemap[43] = 3;
statename[43] = "Jz";
statenamemap[46] = 1;
statename[46] = "N";
statenamemap[47] = 2;
statename[47] = "N";
statenamemap[48] = 3;
statename[48] = "N";
statenamemap[51] = 1;
statename[51] = "Nz";
statenamemap[52] = 2;
statename[52] = "Nz";
statenamemap[53] = 3;
statename[53] = "Nz";
statenamemap[56] = 1;
statename[56] = "O";
statenamemap[57] = 2;
statename[57] = "O";
statenamemap[58] = 3;
statename[58] = "O";
statenamemap[61] = 1;
statename[61] = "OO";
statenamemap[62] = 2;
statename[62] = "OO";
statenamemap[63] = 3;
statename[63] = "OO";
statenamemap[66] = 1;
statename[66] = "Oi";
statenamemap[67] = 2;
statename[67] = "Oi";
statenamemap[68] = 3;
statename[68] = "Oi";
statenamemap[71] = 1;
statename[71] = "T";
statenamemap[72] = 2;
statename[72] = "T";
statenamemap[73] = 3;
statename[73] = "T";
statenamemap[76] = 1;
statename[76] = "Y";
statenamemap[77] = 2;
statename[77] = "Y";
statenamemap[78] = 3;
statename[78] = "Y";
statenamemap[81] = 1;
statename[81] = "YY";
statenamemap[82] = 2;
statename[82] = "YY";
statenamemap[83] = 3;
statename[83] = "YY";
statenamemap[86] = 1;
statename[86] = "Yi";
statenamemap[87] = 2;
statename[87] = "Yi";
statenamemap[88] = 3;
statename[88] = "Yi";
statenamemap[91] = 1;
statename[91] = "a";
statenamemap[92] = 2;
statename[92] = "a";
statenamemap[93] = 3;
statename[93] = "a";
statenamemap[96] = 1;
statename[96] = "aa";
statenamemap[97] = 2;
statename[97] = "aa";
statenamemap[98] = 3;
statename[98] = "aa";
statenamemap[101] = 1;
statename[101] = "ai";
statenamemap[102] = 2;
statename[102] = "ai";
statenamemap[103] = 3;
statename[103] = "ai";
statenamemap[106] = 1;
statename[106] = "aii";
statenamemap[107] = 2;
statename[107] = "aii";
statenamemap[108] = 3;
statename[108] = "aii";
statenamemap[111] = 1;
statename[111] = "au";
statenamemap[112] = 2;
statename[112] = "au";
statenamemap[113] = 3;
statename[113] = "au";
statenamemap[116] = 1;
statename[116] = "auu";
statenamemap[117] = 2;
statename[117] = "auu";
statenamemap[118] = 3;
statename[118] = "auu";
statenamemap[121] = 1;
statename[121] = "c";
statenamemap[122] = 2;
statename[122] = "c";
statenamemap[123] = 3;
statename[123] = "c";
statenamemap[126] = 1;
statename[126] = "ch";
statenamemap[127] = 2;
statename[127] = "ch";
statenamemap[128] = 3;
statename[128] = "ch";
statenamemap[131] = 1;
statename[131] = "ei";
statenamemap[132] = 2;
statename[132] = "ei";
statenamemap[133] = 3;
statename[133] = "ei";
statenamemap[136] = 1;
statename[136] = "eii";
statenamemap[137] = 2;
statename[137] = "eii";
statenamemap[138] = 3;
statename[138] = "eii";
statenamemap[141] = 1;
statename[141] = "f";
statenamemap[142] = 2;
statename[142] = "f";
statenamemap[143] = 3;
statename[143] = "f";
statenamemap[146] = 1;
statename[146] = "h";
statenamemap[147] = 2;
statename[147] = "h";
statenamemap[148] = 3;
statename[148] = "h";
statenamemap[151] = 1;
statename[151] = "i";
statenamemap[152] = 2;
statename[152] = "i";
statenamemap[153] = 3;
statename[153] = "i";
statenamemap[156] = 1;
statename[156] = "ii";
statenamemap[157] = 2;
statename[157] = "ii";
statenamemap[158] = 3;
statename[158] = "ii";
statenamemap[161] = 1;
statename[161] = "j";
statenamemap[162] = 2;
statename[162] = "j";
statenamemap[163] = 3;
statename[163] = "j";
statenamemap[166] = 1;
statename[166] = "k";
statenamemap[167] = 2;
statename[167] = "k";
statenamemap[168] = 3;
statename[168] = "k";
statenamemap[171] = 1;
statename[171] = "kh";
statenamemap[172] = 2;
statename[172] = "kh";
statenamemap[173] = 3;
statename[173] = "kh";
statenamemap[176] = 1;
statename[176] = "l";
statenamemap[177] = 2;
statename[177] = "l";
statenamemap[178] = 3;
statename[178] = "l";
statenamemap[181] = 1;
statename[181] = "lz";
statenamemap[182] = 2;
statename[182] = "lz";
statenamemap[183] = 3;
statename[183] = "lz";
statenamemap[186] = 1;
statename[186] = "m";
statenamemap[187] = 2;
statename[187] = "m";
statenamemap[188] = 3;
statename[188] = "m";
statenamemap[191] = 1;
statename[191] = "mz";
statenamemap[192] = 2;
statename[192] = "mz";
statenamemap[193] = 3;
statename[193] = "mz";
statenamemap[196] = 1;
statename[196] = "n";
statenamemap[197] = 2;
statename[197] = "n";
statenamemap[198] = 3;
statename[198] = "n";
statenamemap[201] = 1;
statename[201] = "nz";
statenamemap[202] = 2;
statename[202] = "nz";
statenamemap[203] = 3;
statename[203] = "nz";
statenamemap[206] = 1;
statename[206] = "oe";
statenamemap[207] = 2;
statename[207] = "oe";
statenamemap[208] = 3;
statename[208] = "oe";
statenamemap[211] = 1;
statename[211] = "oee";
statenamemap[212] = 2;
statename[212] = "oee";
statenamemap[213] = 3;
statename[213] = "oee";
statenamemap[216] = 1;
statename[216] = "oei";
statenamemap[217] = 2;
statename[217] = "oei";
statenamemap[218] = 3;
statename[218] = "oei";
statenamemap[221] = 1;
statename[221] = "oeii";
statenamemap[222] = 2;
statename[222] = "oeii";
statenamemap[223] = 3;
statename[223] = "oeii";
statenamemap[226] = 1;
statename[226] = "ou";
statenamemap[227] = 2;
statename[227] = "ou";
statenamemap[228] = 3;
statename[228] = "ou";
statenamemap[231] = 1;
statename[231] = "ouu";
statenamemap[232] = 2;
statename[232] = "ouu";
statenamemap[233] = 3;
statename[233] = "ouu";
statenamemap[236] = 1;
statename[236] = "p";
statenamemap[237] = 2;
statename[237] = "p";
statenamemap[238] = 3;
statename[238] = "p";
statenamemap[241] = 1;
statename[241] = "pau";
statenamemap[242] = 2;
statename[242] = "pau";
statenamemap[243] = 3;
statename[243] = "pau";
statenamemap[246] = 1;
statename[246] = "ph";
statenamemap[247] = 2;
statename[247] = "ph";
statenamemap[248] = 3;
statename[248] = "ph";
statenamemap[251] = 1;
statename[251] = "r";
statenamemap[252] = 2;
statename[252] = "r";
statenamemap[253] = 3;
statename[253] = "r";
statenamemap[256] = 1;
statename[256] = "rz";
statenamemap[257] = 2;
statename[257] = "rz";
statenamemap[258] = 3;
statename[258] = "rz";
statenamemap[261] = 1;
statename[261] = "s";
statenamemap[262] = 2;
statename[262] = "s";
statenamemap[263] = 3;
statename[263] = "s";
statenamemap[266] = 5;
statename[266] = "pau";
statenamemap[269] = 1;
statename[269] = "t";
statenamemap[270] = 2;
statename[270] = "t";
statenamemap[271] = 3;
statename[271] = "t";
statenamemap[274] = 1;
statename[274] = "th";
statenamemap[275] = 2;
statename[275] = "th";
statenamemap[276] = 3;
statename[276] = "th";
statenamemap[279] = 1;
statename[279] = "u";
statenamemap[280] = 2;
statename[280] = "u";
statenamemap[281] = 3;
statename[281] = "u";
statenamemap[284] = 1;
statename[284] = "uu";
statenamemap[285] = 2;
statename[285] = "uu";
statenamemap[286] = 3;
statename[286] = "uu";
statenamemap[289] = 1;
statename[289] = "v";
statenamemap[290] = 2;
statename[290] = "v";
statenamemap[291] = 3;
statename[291] = "v";
statenamemap[294] = 1;
statename[294] = "x";
statenamemap[295] = 2;
statename[295] = "x";
statenamemap[296] = 3;
statename[296] = "x";
}
{ if (NF < 3)
     print $0;
  else
     printf("%s 125 %d %s\n",$1,statenamemap[$3],statename[$3])
}