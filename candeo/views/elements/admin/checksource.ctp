<script type="text/javascript">
	$(document).ready(function(){
		$("#BiologicalSource").hide();
		$("#ChemicalSource").hide();
		$(".radio").click(function(){
			switch(this.value){
				case "Atomic":
					$("#AtomicSource").show();
					$("#BiologicalSource").hide();
					$("#ChemicalSource").hide();
					break;
				case "Biological":
					$("#AtomicSource").hide();
					$("#BiologicalSource").show();
					$("#ChemicalSource").hide();
					break;
				case "Chemical":
					$("#AtomicSource").hide();
					$("#BiologicalSource").hide();
					$("#ChemicalSource").show();
					break;
				default:
					break;
			}
		});
 });
</script>