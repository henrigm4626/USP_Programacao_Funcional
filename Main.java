import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

//versao nao funcional (imperativa)
class Main {
	
	//classe Info_paises
	//em um projeto normal, estaria fora da classe main
	public static class Info_paises{
		//atributos (seguindo o csv)
		String name;
		int confirmed, deaths, recovery, active;
		
		//construtor
		public Info_paises(String name, int confirmed, int deaths, int recovery, int active) {
			this.name = name;
			this.confirmed = confirmed;
			this.deaths = deaths;
			this.recovery = recovery;
			this.active = active;
		}
		
		//getters
		public String getName() {
			return name;
		}
		
		public int getConfirmed() {
			return confirmed;
		}
		
		public int getDeaths() {
			return deaths;
		}
		
		public int getRecovery() {
			return recovery;
		}
		
		public int getActive() {
			return active;
		}
		
	}
	
	//main
	public static void main(String[] args) throws IOException {
		//recebe n1, n2, n3 e n4
		BufferedReader leitor = new BufferedReader(new InputStreamReader(System.in));
		String entrada = leitor.readLine();
		String[] ns = entrada.split(" ");
		int n1 = Integer.parseInt(ns[0]);
		int n2 = Integer.parseInt(ns[1]);
		int n3 = Integer.parseInt(ns[2]);
		int n4 = Integer.parseInt(ns[3]);
		
		//utilizando csv
		BufferedReader leitor_2 = new BufferedReader(new FileReader("dados.csv"));
		List<String[]> linhas_csv = new ArrayList<>();
		String linha_aux;
        while ((linha_aux = leitor_2.readLine()) != null) {
            String[] colunas = linha_aux.split(",");
            linhas_csv.add(colunas);
        }
        String[][] tabela_csv = new String[linhas_csv.size()][];
        for (int i = 0; i < linhas_csv.size(); i++) {
            tabela_csv[i] = linhas_csv.get(i);
        }
        
        //passando para um array de paises
        Info_paises [] paises = new Info_paises[tabela_csv.length];;
        for(int i = 0; i < tabela_csv.length; i++) {
        	paises[i] = new Info_paises(tabela_csv[i][0],Integer.parseInt(tabela_csv[i][1]), Integer.parseInt(tabela_csv[i][2]), Integer.parseInt(tabela_csv[i][3]), Integer.parseInt(tabela_csv[i][4]));
        }
        
        //primeira saida
        //(A soma de "Active" de todos os países em que "Confirmed" é maior ou igual a n1)
        int res_1 = 0;
        //percorrendo todos os paises
        for(Main.Info_paises pais : paises) {
        	if(pais.getConfirmed() >= n1) {
        		res_1 += pais.getActive();
        	}
        }
        System.out.println(res_1);
        
        //segunda saida
        //Dentre os n2 países com maiores valores de "Active", o "Deaths" dos n3 países com menores valores de "Confirmed")
        Arrays.sort(paises, Comparator.comparingInt(pais -> pais.getActive()));
        Info_paises[] paises_sorted_1 = Arrays.copyOfRange(paises, paises.length - n2, paises.length);
        Arrays.sort(paises_sorted_1, Comparator.comparingInt(pais -> pais.getConfirmed()));
        for(int i = 0; i < n3 && i < paises_sorted_1.length; i++) {
        	System.out.println(paises_sorted_1[i].getDeaths());
        }
        
        //terceira saida
        //Os n4 países com os maiores valores de "Confirmed". Os nomes devem estar em ordem alfabética.
        Arrays.sort(paises, Comparator.comparingInt(pais -> pais.getConfirmed()));
        Info_paises[] paises_sorted_2 = Arrays.copyOfRange(paises, paises.length - n4, paises.length);
        Arrays.sort(paises_sorted_2, Comparator.comparing(pais -> pais.getName()));
        
        for(int i = 0; i < paises_sorted_2.length; i++) {
        	System.out.println(paises_sorted_2[i].getName());
        }
	}
}
