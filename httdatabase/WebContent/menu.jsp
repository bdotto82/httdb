
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="/cabecalho.jsp" %>

 <div class="borda-janela" style="width: 100%; padding-top: 8px; padding-bottom: 8px; text-align: left;">
    <a href="<%=request.getContextPath()%>/index.jsp" style="margin-left: 10px;" class="easyui-linkbutton" data-options="plain:true">Home</a>
    <a href="#" class="easyui-menubutton" data-options="menu:'#mm1',plain:true">Database Search</a>
    <a href="<%=request.getContextPath()%>/script/scriptform.jsp" class="easyui-linkbutton" data-options="plain:true"><font style="color:red"><b>VHICA online</b></font></a>
    <a href="#" class="easyui-menubutton" data-options="menu:'#mm2',plain:true">Add new data</a>
    <a href="#" class="easyui-menubutton" data-options="menu:'#mm3',plain:true">Downloads</a>
    <a href="<%=request.getContextPath()%>/about/about.jsp" class="easyui-linkbutton" data-options="plain:true">Help</a>
    <a href="<%=request.getContextPath()%>/usefull_links.jsp" class="easyui-linkbutton" data-options="plain:true">Useful Links</a>
    <a href="<%=request.getContextPath()%>/contact.jsp" class="easyui-linkbutton" data-options="plain:true">Contact</a>

    <div id="mm1" class="menu-content" style="text-align: center; width: 180px; ">
	    <a href="<%=request.getContextPath()%>/clado.jsp" style="width: 160px;" class="easyui-linkbutton" data-options="plain:true">HTT Host Cladogram</a>
	    <br>
	    <a href="<%=request.getContextPath()%>/hvtclado.jsp" style="width: 160px;" class="easyui-linkbutton" data-options="plain:true">HVT Host Cladogram</a>
		<br>
	    <a href="<%=request.getContextPath()%>/resultado/resultado.jsp" style="width: 160px;" class="easyui-linkbutton" data-options="plain:true">Transposable Elements</a>
	    <br>
	    <a href="<%=request.getContextPath()%>/hvt/hvt.jsp" style="width: 160px;" class="easyui-linkbutton" data-options="plain:true">Virus</a>
    </div>


    <div id="mm2" class="menu-content" style="text-align: center; width: 180px; ">
	    <a href="<%=request.getContextPath()%>/howtoadd.jsp" class="easyui-linkbutton" data-options="plain:true">HTT Database (TE)</a>
	    <br>
    	<a href="<%=request.getContextPath()%>/howtoadd_hvt.jsp" class="easyui-linkbutton" data-options="plain:true">HVT Database (Virus)</a>
    </div>

    <div id="mm3" class="menu-content" style="text-align: center; width: 250px; ">
	    <a href="<%=request.getContextPath()%>/repbase_seq/repbase_seq.fasta.zip" class="easyui-linkbutton" data-options="plain:true">Sequences Involved in HTT</a>
	    <br>
    	<a href="<%=request.getContextPath()%>/repbase_seq/hvt_seq.fasta.zip" class="easyui-linkbutton" data-options="plain:true">Sequences From Endogenization Events</a>
    </div>


</div>


<!-- MENSAGEM DE ALERTA -->
<div id="dialog-alert" title="Atenção" style="display: none;">
  <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0; "><div id="msg-dialog-alert">.</div></span></p>
</div>

<!-- MENSAGEM DE CONFIRMAÇÃO -->
<div id="dialog-confirm" title="Atenção" style="display: none;">
  <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0; "></span><div id="msg-confirm-alert">Confirma o cancelamento da edição do cliente?</div></p>
</div>

<!-- MENSAGEM DE LOGIN -->
<div id="dialog-login" title="Login" style="display: none;">
	<form action=# id="formlogin" name="formlogin">
		<label style="width: auto;">User:</label><br><input type="text" name="nm_usuario" id='nm_usuario' style="width: 230px;"><br>
		<label style="width: auto;">Password:</label><br><input type="password" name="ds_senha"style="width: 230px;"><br>
	</form>
</div>

	