<h2><?php echo $record['Record']['name']?></h2>
	<?php echo $html->link('Edit', '/records/edit/'.$record['Record']['id'], array('class'=>'edit')); ?>
<p class="dates"><span>created:</span><?php echo $record['Record']['created']?><span>modified:</span><?php echo $record['Record']['modified']?></p>
<dl>
	<dt>Institute</dt><dd><?php echo $record['Institute']['name']?></dd>
	<dt>Building</dt><dd><?php echo $record['Building']['name']?></dd>
	<dt>Version</dt><dd><?php echo $record['Record']['version']?></dd>
	<dt>Source Type</dt><dd><?php echo $record['Record']['source_type']?></dd>
	<?php
		switch($record['Record']['source_type']){
			case 'Atomic':
				echo "<dt>Source</dt><dd>".$record['Atomic']['name']."</dd>";
				break;
			case 'Biological':
				echo "<dt>Source</dt><dd>".$record['Biological']['name']."</dd>";
				break;
			case 'Chemical':
				echo "<dt>Source</dt><dd>".$record['Chemical']['name']."</dd>";
				break;
			default:
				break;
		};
	?>
	<dt>Amount</dt><dd><?php echo $record['Record']['amount']?></dd>
	<dt>Room</dt><dd><?php echo $record['Record']['room']?></dd>
	<dt>Floor</dt><dd><?php echo $record['Record']['floor']?></dd>
	<dt>Notes</dt><dd><?php echo $record['Record']['notes']?></dd>
</dl>
<div id="page_nav">
	<?php echo $html->link('Back', '/records',  array('class'=>'back')); ?>
</div>