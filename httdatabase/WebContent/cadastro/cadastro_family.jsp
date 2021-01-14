<fieldset>

	<form name='form-family' id='form-family'>

		<input type="hidden" name='acao' value="I">
		<input type="hidden" name='id_family' >
		<label style="width:auto;">Class:</label><br>
		<select id='id_classe_form_family' name='id_classe' style="width: 200px;" 
		        onChange="carregaselect('superfamily', 'id_superfamily_form_family', 0, 0, 'id_classe=' + this.value); document.forms['form-family']['id_superfamily'].value='';">
		</select><br>
		<label style="width:auto;">Super Family:</label><br>
		<select id='id_superfamily_form_family' name='id_superfamily' style="width: 200px;">
		</select><br>
		<label style="width:auto;">Family:</label><br>
		<input type='text' name='nm_family' style="width:445px;" title='Family'><br>

	</form>

</fieldset>