<script src="${Request.getContextPath()}/js/jquery-1.7.2.min.js"></script>
<link href="${Request.getContextPath()}/css/bootstrap.min.css" rel="stylesheet">
<link href="${Request.getContextPath()}/css/bootstrap-responsive.min.css" rel="stylesheet">
<script src="${Request.getContextPath()}/plugins/tree/jquery.ztree.all-3.2.js"></script>
<link rel="stylesheet" href="${Request.getContextPath()}/plugins/tree/zTreeStyle.css" type="text/css">

<script type="text/javascript">
		
						var setting = {
							view: {
								showLine: true,
								showIcon : false
							},
							data: {
								simpleData: {
									enable: true
								}
							},
							callback: {
										onClick : zTreeOnClick
							}
						};
		
						function zTreeOnClick(event, treeId, treeNode){
										var nodeId = treeNode.id;
										if(nodeId == 'A'||nodeId == 'U'||nodeId == 'S'){
											    document.location.href ="${Request.getContextPath()}/user/list?roleName="+nodeId;
										}else if(nodeId != 'all'){
												document.location.href ="${Request.getContextPath()}/user/detail?userId="+nodeId;
										}else{
												document.location.href ="${Request.getContextPath()}/user/list";
										}
										
						}
						
						var treeData = ${jsonStr}
						
						$(document).ready(function(){
									$.fn.zTree.init($("#treeDemo"), setting, treeData);
						});
			
</script>
		
<div id="userTree_div_id">
	<ul id="treeDemo" class="ztree"></ul>	
</div>	
										