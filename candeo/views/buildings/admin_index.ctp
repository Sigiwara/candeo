<h2>Buildings<span class="count"><strong><?php echo count($buildings)."</strong> recorded"?></span></h2>
	<?php echo $html->link('Add', array('action'=>'add'), array('class'=>'edit')); ?>
<table>
	<tr>
		<th><?php echo $paginator->sort('Id', 'id'); ?></th>
		<th><?php echo $paginator->sort('Name', 'name'); ?></th>
		<th><?php echo $paginator->sort('Adress', 'adress'); ?></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>

	<?php foreach ($buildings as $building): ?>
	<tr>
		<td><?php echo $building['Building']['id']; ?></td>
		<td>
			<?php echo $html->link($building['Building']['name'], "/buildings/view/".$building['Building']['id']); ?>
		</td>
		<td>
			<?php echo $building['Building']['street']." ".$building['Building']['number']; ?> 
		</td>
		<td>
		<?php echo $html->link('Edit', '/buildings/edit/'.$building['Building']['id']);?>
		</td>
		<td>
			<?php echo $html->link('Delete', "/buildings/delete/{$building['Building']['id']}", null, 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav">
	<?php echo $html->link('Back', '/', array('class' => 'back')); ?>
</div>