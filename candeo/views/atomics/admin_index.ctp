<h2>Atomics</h2>
	<?php echo $html->link('Add', array('action'=>'add'), array('class'=>'edit')); ?>
<table>
	<tr>
	<th><?php echo $paginator->sort('Id', 'id'); ?></th>
	<th><?php echo $paginator->sort('Name', 'name'); ?></th>
	<th><?php echo $paginator->sort('Open', 'open'); ?></th>
	<th><?php echo $paginator->sort('Type', 'type'); ?></th>
	<th>Edit</th>
	<th>Delete</th>
	</tr>

	<?php foreach ($atomics as $atomic): ?>
	<tr>
		<td><?php echo $atomic['Atomic']['id']; ?></td>
		<td>
			<?php echo $html->link($atomic['Atomic']['name'], "/atomics/view/".$atomic['Atomic']['id']); ?>
		</td>
		<td>
			<?php echo $atomic['Atomic']['open']; ?>
		</td>
		<td>
			<?php echo $atomic['Atomic']['type']; ?>
		</td>
		<td>
		<?php echo $html->link('Edit', '/atomics/edit/'.$atomic['Atomic']['id']);?>
		</td>
		<td>
			<?php echo $html->link('Delete', "/atomics/delete/{$atomic['Atomic']['id']}", null, 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav">
	<?php echo $html->link('Back', '/', array('class' => 'back')); ?>
</div>