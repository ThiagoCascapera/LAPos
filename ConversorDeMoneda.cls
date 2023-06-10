public with sharing class ConversorDeMoneda {
    static String[] ate19        = new String[] {'Cero', 'Uno',  'Dos', 'Tres', 'Cuatro',  'Cinco',  'Seis', 'Siete','Ocho', 'Nueve', 'Diez',  'Once', 'Doce', 'Trece', 'Catorce', 'Quince', 'Dieciséis', 'Diecisiete', 'Dieciocho', 'Diecinueve', 'Veinte', 'Veintiuno', 'Veintidós', 'Ventitrés', 'Veinticuatro', 'Veinticinco',
        'Veintiséis', 'Veintisiete','Veintiocho', 'Veintinueve'};
            static String[] dezenas      = new String[] { 'Treinta ', 'Cuarenta', 'Cincuenta', 'Sesenta', 'Setenta', 'Ochenta', 'Noventa'};
                static String[] centenas     = new String[] {'', 'Ciento', 'Doscientos', 'Trescientos', 'Cuatrocientos', 'Quinientos', 'Seiscientos', 'Setecientos', 'Ochocientos', 'Novecientos'};
                    static String[] denom        = new String[] {'', 'Mil', 'Millón', 'Billón', 'Trillón'};
                        static String[] denom_plural = new String[] {'', 'Mil', 'Millones', 'Billones', 'Trillones'};
                            
                            public static String ConverteAteCem(Long val) {
                                if (val < 30)
                                    return ate19[(Integer)val];
                                if (val == 100)
                                    return 'Cien';
                                for (Long v = 0; v < dezenas.size(); v++) {
                                    String dcap = dezenas[(Integer)v];
                                    Long dval = 30 + 10 * v;
                                    if (dval + 10 > val) {
                                        if (Math.Mod(val,10) != 0) {
                                            
                                        }
                                        return dcap + ((Integer)Math.Mod(val,10)!=0?' y ' +  ate19[(Integer)Math.Mod(val,10)]: '');
                                        
                                    }     
                                } 
                                
                                return 'Valor inválido';
                            }
    
    /*public String extenso(Decimal valor,String tipo){
        if(tipo == 'pesos'){
            if (valor != null && valor >= 0) {
                String[] n = String.valueOf(valor).split('\\.');
                if (n.size() == 1 || Integer.valueOf(n[1]) == 0 ){
                    return valor.format()+' ('+get_value(Long.valueOf(n[0])) + ' pesos.)';
                }else{
                    return valor.format()+' ('+get_value(Long.valueOf(n[0])) + ' pesos y ' + get_value(Long.valueOf(n[1])) + ' Centavos.)';
                }
            } else {
                return '## ERRO #';
            } 
        }else{
            if (valor != null && valor >= 0) {
                String[] n = String.valueOf(valor).split('\\.');
                if (n.size() == 1 || Integer.valueOf(n[1]) == 0 ){
                    return valor.format()+' ('+get_value(Long.valueOf(n[0])) + ')';
                }else{
                    return valor.format()+' ('+get_value(Long.valueOf(n[0])) + ' y ' + get_value(Long.valueOf(n[1])) + ')';
                }
            } else {
                return '## ERRO #';
            } 
        }
    }*/
    
    public static String get_value(long val){
        if (String.valueOf(val).length() <= 3){
            return conversao((Long)val);
        }else{
            for (Long v = 0; v < denom.size(); v++) {
                Long didx = v - 1;
                Long dval = (Long)Math.pow(1000, v);
                if (dval > val) {
                    Long mod = (Long) Math.pow(1000, didx);
                    Long l =   (Long) val / mod;
                    Long r =   (Long) val - (l * mod);
                    String  ret = l == 1? conversao(l) + ' ' + denom[(Integer)didx] : conversao(l) + ' ' + denom_plural[(Integer)didx];
                    System.Debug(didx);
                    if (r > 0) {
                        if(r != 100){
                            ret += ', ' + get_value(r);
                        }else{
                            ret += ' y ' + get_value(r);
                        }
                    }
                    return ret;
                } 
            } 
            return 'Valor inválido'; 
        }
    }
    
    public static String conversao(long v){
        if (v == 100) return 'Cien ';
        String word = '';
        Long casted = (Long)v;
        String[] a = String.valueOf(v).split('');
        Long m = Long.valueOf(a[0]);
        
        if(String.valueOf(v).length() >= 3){
            //verifica se a casa das unidades é zero
            if(a[2] != '0'){
                //verifica se a casa das centenas é zero
                if(m != 0){
                    Long x = m * 100;
                    Long rem = casted / x;
                    Long mod = Math.mod(casted, x);
                    if (rem > 0) {
                        word = centenas[(Integer)m] + ' y';
                        if (mod > 0) { 
                            word += ' '; 
                        } 
                    } 
                    if (mod > 0) {
                        word += ConverteAteCem(mod);
                    } 
                    return word;
                }else{
                    return '';
                }
            }else{
                if (a[1] == '0'){
                    if (m != 0){
                        word += centenas[(Integer)m];
                        return word;
                    }else{
                        return '';
                    }
                }else{
                    if (m != 0){
                        Long x = m * 100;
                        Long rem = casted / x;
                        Long mod = Math.mod(casted, x);
                        if (rem > 0) {
                            word = centenas[(Integer)m] + ' y';
                            if (mod > 0) {
                                word += ' ';
                            } 
                        } 
                        if (mod > 0) {
                            word += ConverteAteCem(mod);
                        } 
                        return word;
                    }else{
                        return '';
                    }
                }
            }
        }else{
            if (v <=19)
                return String.valueOf(ate19[(Integer)casted]);
            else
                return String.valueOf(ConverteAteCem(casted));
        }
    }
    
    public static String convert(String d){
        Decimal a = Decimal.valueOf(d);
        
        system.debug('Decimal '+d);
        if(d==null){
            return null;
        }
        String dStr = String.valueOf(d);
        String decimalStr='00';
        if(dStr!=null && dStr.contains('.')){
            system.debug(' entre if 154 ');
            decimalStr = dStr.substringAfter('.');
        } 
        Decimal p = decimal.valueOf(decimalStr);
        String retStr = get_value(a.longValue());
        system.debug('retStr '+retStr);
        retStr +=' y '+get_value(p.longValue())+' Centavos.';
        
        return retStr;
    }
    
}