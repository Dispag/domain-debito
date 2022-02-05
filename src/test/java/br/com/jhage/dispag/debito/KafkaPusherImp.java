package br.com.jhage.dispag.debito;

import br.com.jhage.dispag.debito.service.PusherService;

/**
 * 
 * @author Alexsander Melo
 * @since 10/10/2021
 *
 */
public class KafkaPusherImp implements PusherService{

	
	private Boolean executouPosh;
	
	public static PusherService newInstance() {
		
		return new KafkaPusherImp();
	}
	
	public KafkaPusherImp() {
		
		
		this.executouPosh = false;
	}
	
	public Boolean executouPosh() {
		
		return this.executouPosh;
	}
	@Override
	public Boolean push(String topic, String payload){

		System.out.println("==> Execução kafkaPusherImp.");
		this.executouPosh = true;
		return this.executouPosh;
	}

}
