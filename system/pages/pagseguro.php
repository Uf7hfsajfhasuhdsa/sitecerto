<div class='message'>
<div class='title'>PREMIUM POINTS</div>
<div class='content'>
</div>
</div>

<?php
	global $config;
	require("config.php");
	$ots = POT::getInstance();
	$ots->connect(POT::DB_MYSQL, connection());
	$SQL = $ots->getDBHandle();
	$ide = new IDE;
	$ide->requireLogin();
	if($ide->isLogged()){
		$accountName = $_SESSION['name'];
		//$SQL->query('SELECT * FROM accounts WHERE name="'.$accountName.'"')->fetch();
	?>
	<form target="pagseguro" method="post" action="https://pagseguro.uol.com.br/checkout/checkout.jhtml">
		<input type="hidden" name="email_cobranca" value="guiknepper15@gmail.com">
		<input type="hidden" name="tipo" value="CP">
		<input type="hidden" name="moeda" value="BRL">
		<input type="hidden" name="item_id_1" value="1">
		<input type="hidden" name="item_descr_1" value="<?php echo $config['pagseguro']['produtoNome']; ?>">
		<input type="hidden" name="item_valor_1" value="100">
		<input type="hidden" name="item_frete_1" value="0">
		<input type="hidden" name="item_peso_1" value="0">
		<input type="hidden" name="ref_transacao" value="<?php echo $accountName; ?>">
		<table border="0" cellpadding="4" cellspacing="1" width="100%" id="#estilo">
			<tbody>
				<tr>
					<th colspan="2">Assim que sua doação for confirmada seus pontos terão até 24 horas para ser ativados em sua conta.</th>
				</tr>
				<tr>
					<th colspan="2">&nbsp;</th>
				</tr>
				<tr>
					<th colspan="2">Escolha a quantidade de pontos que deseja comprar:</th>
				</tr>
				<tr>
					<th colspan="2">
						<div align="center">
							<table border="1" width="450">
								<thead>
									<tr>
										<th colspan="2" align="center">Selecione o valor corretamente:</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td width="45%" align="center">Sua Conta:</td>
										<td width="55%" align="center"><strong><?php echo $accountName; ?></strong></td>
									</tr>
									<tr>
										<td width="45%" align="center">Premium Points:</td>
										<td width="55%" align="center">
											<input name="item_quant_1" type="text" value="1" size="5" maxlength="5">
										</td>
									</tr>
									<tr>
										<td colspan="2"><div align="center"><input type="image" src="https://p.simg.uol.com.br/out/pagseguro/i/botoes/carrinhoproprio/btnFinalizar.jpg" name="submit" alt="Pague com PagSeguro - é rápido, grátis e seguro!"></div>
									</tr>
								</tbody>
							</table>
						</div>
					</th>
				</tr>
				<tr>
					<th colspan="2">
						<br>LEIA ISSO PARA EVITAR PROBLEMAS !!!</b>.
						<br>Pedimos que após efetuar sua doação, nos envie a foto do comprovante de pagamento e o numero de transação + o nick do seu personagem para o nosso email: ntofunonline@gmail.com, iremos lhe atender em até 24 horas.
						<br><br><br>Simples não? rs... Quero que entendam que o dinheiro doado, por vocês jogadores, irá favorecer a vocês mesmos, pois o dinheiro vai ser usado no dedicado 24hrs para que possam curtir o jogo por mais tempo.
						<br><br><br><br><br><font size="5">Equipe NTO FUN</font>
						<br><font size="2">agradece a preferência.</font>
					</th>
				</tr>
			</tbody>
		</table>
	</form>
<?php } ?>