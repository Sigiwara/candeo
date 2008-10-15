<h2><?php echo $institute['Institute']['name']?></h2>
<div class="actions">
	<ul>
		<li><?php echo $html->link('Edit', array('controller'=>'records', 'action'=>'set', $institute['Institute']['id']), array('class'=>'btn')); ?></li>
		<li><?php echo $html->link('Export', array('action'=>'export', 'admin'=>false), array('class'=>'btn')); ?></li>
	</ul>
</div>
<table>
	<tr><th>Name</th><th>Amount</th><th>Building</th></tr>
	<?php
		$i = 0;
		foreach ($records as $record) {
			?>
			<tr>
				<td><?php echo $record['Record']['name'] ?></td>
				<td><?php echo $record['Record']['amount'] ?></td>
				<td><?php echo $record['Record']['building'] ?></td>
			</tr>
		<?php
			$i++;
		}
	?>
</table>
<div id="page_nav">
	<?php echo $html->link('Back', array('action'=>'index',),  array('class'=>'back')); ?>
</div>