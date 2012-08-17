<!DOCTYPE html>
<html>
	<head>
		<#include "../common/common.ftl">
		<#include "../common/datatables.ftl">
		<title><@spring.message "script.list.title"/></title>
	</head>

	<body>
    <#include "../common/navigator.ftl">
	<div class="container">
		<div class="well form-inline searchBar" style="margin-top:0;">
			<!--<legend>introduction</legend>-->
			<input type="text" class="search-query" placeholder="Keywords" id="searchText" value="${keywords!}">
			<button type="submit" class="btn" id="searchBtn"><i class="icon-search"></i> <@spring.message "common.button.search"/></button>
			<#if svnUrl?has_content>
			<div class="input-prepend pull-right" rel="popover" 
               		data-content="User can access scripts through Subversion.&lt;br&gt; Please access the following URL with your Subversion client"
               		 data-original-title="Subversion" placement="bottom"/> 
               <span class="add-on" style="cursor:default">SVN</span><span class="input-xlarge uneditable-input span6" style="cursor:text">${svnUrl}</span>
        	</div> 
        	</#if>	
        	<div style="margin-top:10px">
				<a class="btn btn-primary" href="#createScriptModal" id="createBtn" data-toggle="modal">
					<i class="icon-file"></i>
					<@spring.message "script.list.button.createScript"/>
				</a>
				<a class="btn" href="#createFolderModal" id="folderBtn" data-toggle="modal">
					<i class=" icon-folder-open"></i>
					<@spring.message "script.list.button.createFolder"/>
				</a>
				<a class="btn" href="#uploadScriptModal" id="uploadBtn" data-toggle="modal">
					<i class="icon-upload"></i>
					<@spring.message "script.list.label.upload"/>
				</a>
				<a class="btn btn-danger pull-right" href="javascript:void(0);" id="deleteBtn">
					<i class="icon-remove"></i>
					<@spring.message "script.list.button.delete"/>
				</a>
			</div>
		</div>
			
		<table class="table table-striped table-bordered ellipsis" id="scriptTable">
			<colgroup>
				<col width="30">
				<col width="35">
				<col width="250"> 
				<col>
				<col width="150">
				<col width="75">
				<col width="60">
			</colgroup> 
			<thead>
				<tr>
					<th><input type="checkbox" class="checkbox" value=""></th>
					<th><a href="${req.getContextPath()}/script/list/${currentPath}/../" target="_self"><img src="${req.getContextPath()}/img/up_folder.png"/></a> 
					</th>
					<th><@spring.message "script.option.name"/></th>
					<th class="noClick"><@spring.message "script.option.commit"/></th>
					<th><@spring.message "script.list.table.lastDate"/></th>
					<th><@spring.message "script.list.table.size"/></th>
					<th class="noClick"><@spring.message "script.list.table.actions"/></th>
				</tr>
			</thead>
			<tbody>
				<#if files?has_content>	
					<#list files as script>
						<tr>
							<td><#if script.fileName != ".."><input type="checkbox" value="${script.fileName}"></#if></td>
							<td>
								<#if script.fileType.fileCategory.isEditable()>
									<i class="icon-file"></i>
								<#elseif script.fileType == "dir">
									<i class="icon-folder-open"></i>
								<#else>	
									<i class="icon-briefcase"></i>
								</#if>
							</td>
							<td>
								<#if script.fileType.fileCategory.isEditable()>
									<a href="${req.getContextPath()}/script/detail/${script.path}" target="_self">${script.fileName}</a>
								<#elseif script.fileType == "dir">
									<a href="${req.getContextPath()}/script/list/${script.path}" target="_self">${script.fileName}</a>
								<#else>	
									<a href="${req.getContextPath()}/svn/${currentUser.userId}/${script.path}" target="_blank">${script.fileName}</a>
								</#if>
							</td>
							<td class="ellipsis" title="${(script.description)!}">${(script.description)!}</td>
							<td><#if script.lastModifiedDate?exists>${script.lastModifiedDate?string('yyyy-MM-dd HH:mm')}</#if></td>
							<td><#assign floatSize = script.fileSize?number/1024>${floatSize?string("0.##")}</td>
							<td><a href="javascript:void(0);"><i class="icon-download-alt script-download" spath="${script.path}" sname="${script.fileName}"></i></a></td>
						</tr>
					</#list>
				<#else>
					<tr>
						<td colspan="7" class="noData">
							<@spring.message "common.message.noData"/>
						</td>
					</tr>
				</#if>		
				</tbody>
				</table>
				<#include "../common/copyright.ftl">
			</div>
		</div>

		<div class="modal fade" id="createScriptModal">
			<div class="modal-header">
				<a class="close" data-dismiss="modal" id="createCloseBtn">&times;</a>
				<h3><@spring.message "script.list.button.createScript"/></h3>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" method="post" target="_self" id="createForm" action="${req.getContextPath()}/script/create/${currentPath}">
					<fieldset>
						<div class="control-group">
							<label for="scriptNameInput" class="control-label"><@spring.message "script.option.name"/></label>
							<div class="controls">
							  <input type="text" id="scriptNameInput" name="fileName">
							  <span class="help-inline"></span>
							</div>
						</div>
						<div class="control-group">
							<label for="languageSelect" class="control-label"><@spring.message "script.list.label.type"/></label>
							<div class="controls">
								<input type="hidden" name="type" value="script"/>
								<select id="languageSelect" name="scriptType">
									<option value="py">Python</option>
								</select>
							  <span class="help-inline"></span>
							</div>
						</div>
						<div class="control-group">
							<label for="urlInput" class="control-label"><@spring.message "script.list.label.url"/></label>
							<div class="controls">
							  <input type="text" id="urlInput" name="testUrl"/>
							  <span class="help-inline"></span>
							</div>
						</div>					
					</fieldset>
				</form>
			</div>
			
			<div class="modal-footer">
				<a href="#" class="btn btn-primary" id="createBtn2"><@spring.message "common.button.create"/></a>
				<a href="#createScriptModal" class="btn" id="cancelBtn" data-toggle="modal"><@spring.message "common.button.cancel"/></a>
			</div>
		</div>
		
		<div class="modal fade" id="createFolderModal">
			<div class="modal-header">
				<a class="close" data-dismiss="modal" id="createCloseBtn">&times;</a>
				<h3><@spring.message "script.list.button.createFolder"/></h3>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" method="post" target="_self" id="createFolderForm" action="${req.getContextPath()}/script/create/${currentPath}">
					<fieldset>
						<div class="control-group">
							<label for="folderNameInput" class="control-label"><@spring.message "script.list.label.folderName"/></label>
							<div class="controls">
							  <input type="hidden" name="type" value="folder"/>
							  <input type="text" id="folderNameInput" name="folderName"/>
							  <span class="help-inline"></span>
							</div>
						</div>					
					</fieldset>
				</form>
			</div>
			
			<div class="modal-footer">
				<a href="#" class="btn btn-primary" id="createFolderBtn"><@spring.message "common.button.create"/></a>
				<a href="#createFolderModal" class="btn" id="cancelBtn" data-toggle="modal"><@spring.message "common.button.cancel"/></a>
			</div>
		</div>
	
		<div class="modal fade" id="uploadScriptModal">
			<div class="modal-header">
				<a class="close" data-dismiss="modal" id="upCloseBtn">&times;</a>
				<h3><@spring.message "script.list.button.upload"/></h3>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" method="post" target="_self" action="${req.getContextPath()}/script/upload"
						id="uploadForm" enctype="multipart/form-data">
					<fieldset>
						<div class="control-group">
							<label for="upScriptNameInput" class="control-label"><@spring.message "script.list.label.fileName"/></label>
							<div class="controls">
							  <input type="text" id="upScriptNameInput" name="fileName">
							  <input type="hidden" id="path" name="path"/>
							  <span class="help-inline"></span>
							</div>
						</div>
						<div class="control-group">
							<label for="discriptionInput" class="control-label"><@spring.message "script.option.commit"/></label>
							<div class="controls">
							  <input type="text" id="discriptionInput" name="description">
							  <span class="help-inline"></span>
							</div>
						</div>
						<div class="control-group">
							<label for="fileInput" class="control-label"><@spring.message "script.list.label.file"/></label>
							<div class="controls">
							  <input type="file" class="input-file" id="fileInput" name="uploadFile">
							  <span class="help-inline"></span>
							</div>
						</div>				
					</fieldset>
				</form>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn btn-primary" id="uploadBtn2"><@spring.message "script.list.button.upload"/></a>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			$("#n_script").addClass("active");
			
			$("#createBtn2").on('click', function() {
				document.forms.createForm.submit();
			});
			
			$("#uploadBtn2").on('click', function() {
			
				$("#path").val($("#upScriptNameInput").val());
				document.forms.uploadForm.submit();
			});
			
			$("#createFolderBtn").on('click', function() {
				
				document.forms.createFolderForm.submit();
			});
						
			$("#deleteBtn").on('click', function() {
				var ids = "";
				var list = $("td input:checked");
				if(list.length == 0) {
					alert("<@spring.message "script.list.alert.delete"/>");
					return;
				}
				if (confirm('<@spring.message "script.list.confirm.delete"/>')) {
					var agentArray = [];
					list.each(function() {
						agentArray.push($(this).val());
					});
					ids = agentArray.join(",");
					
					document.location.href = "${req.getContextPath()}/script/delete/${currentPath}?filesString=" + ids;
				}
			});
			
			$("#searchBtn").on('click', function() {
				searchScriptList();
			});

			$("#onlyMineCkb").on('click', function() {
				searchScriptList();
			});
			
			$("td input").on("click", function() {
				if($("td input").size() == $("td input:checked").size()) {
						$("th input").attr("checked", "checked");
				} else {
					$("th input").removeAttr("checked");
				}
			});
			
			$("th input").on('click', function(event) {
				if($(this)[0].checked) {
					$("td input").each(function(){
						$(this).attr("checked", "checked");
					});
				} else {
					$("td input").each(function() {
						$(this).removeAttr("checked");
					});
				}
				
				event.stopImmediatePropagation();
			});
			
			$("i.script-download").on('click', function() {
				var $elem = $(this);
				document.forms.downloadForm.action = "${req.getContextPath()}/svn/" + $elem.attr("spath");
				document.forms.downloadForm.submit();
			});

			<#if files?has_content>
				$("#scriptTable").dataTable({
					"bAutoWidth": false,
					"bFilter": false,
					"bLengthChange": false,
					"bInfo": false,
					"iDisplayLength": 10,
					"aaSorting": [[2, "asc"]],
					"bProcessing": true,
					"aoColumns": [{ "asSorting": []}, { "asSorting": []}, null, { "asSorting": []}, null, null, { "asSorting": []}],
					"sPaginationType": "bootstrap"
				});
			</#if>
			
			$(".noClick").off('click');
			
		});
		
		function searchScriptList() {
			document.location.href = "${req.getContextPath()}/script/search?query=" + $("#searchText").val();
		}
	</script>
	</body>
</html>