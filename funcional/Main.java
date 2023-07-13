import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Stream;
import java.util.stream.Collectors;
//versao funcional
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
		Stream<String> linhas_csv = Files.lines(Paths.get("dados.csv"));
		
		//recolhendo uma lista de paises
		List<Info_paises> paises = linhas_csv
				.map(linha -> {
					String[] valores = linha.split(",");//separa os valores pelas virgulas (por ser csv)
					String name = valores[0];
					int confirmed, deaths, recovered, active;
					confirmed = Integer.parseInt(valores[1]);
					deaths = Integer.parseInt(valores[2]);
					recovered = Integer.parseInt(valores[3]);
					active = Integer.parseInt(valores[4]);
					return new Info_paises(name, confirmed, deaths, recovered, active);
				})
				.collect(Collectors.toList());
		
		//Primeira saida
		int res_1; //(A soma de "Active" de todos os países em que "Confirmed" é maior ou igual a n1)
		res_1 = paises
				.stream()
				.filter(pais -> pais.getConfirmed() >= n1)
				.mapToInt(Info_paises::getActive)
				.sum(); 
		System.out.println(res_1);
		
		
		//Segunda saida
		//Dentre os n2 países com maiores valores de "Active", o "Deaths" dos n3 países com menores valores de "Confirmed")
		//lista dos n2 paises com maiores active
		List<String> paises_maiores_active = paises.stream()
                .sorted(Comparator.comparingInt(Info_paises::getActive)
                		.reversed())
                .limit(n2)
                .map(Info_paises::getName)
                .collect(Collectors.toList());
		
		//recolhe o deaths dos n3 paises com menores valores de confirmed (dentre paises_maiores_active) e mostra na tela
	        paises
	        .stream()
	        .filter(pais -> paises_maiores_active.contains(pais.getName()))
	        .sorted(Comparator.comparingInt(Info_paises::getConfirmed))
	        .limit(n3)
	        .map(Info_paises::getDeaths)
	        .forEach(deaths -> System.out.println(deaths + " "));
	        
	        //terceira saida
	        //Os n4 países com os maiores valores de "Confirmed". Os nomes devem estar em ordem alfabética.
	        paises
	        .stream()
	        .sorted(Comparator.comparingInt(Info_paises::getConfirmed)
	        		.reversed()
	        		.thenComparing(Info_paises::getName))
	        .limit(n4)
	        .map(Info_paises::getName)
	        .sorted()
	        .forEach(pais -> System.out.println(pais + " "));
	        
	        linhas_csv.close();
	        		
	}
}
