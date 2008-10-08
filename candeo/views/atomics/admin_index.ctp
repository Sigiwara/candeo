<h2>Atomics <span class="count"><strong><?php echo $paginator->counter(array('format' => __('%count% ', true))); __('recorded')?></span></h2>
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
			<?php echo $html->link($atomic['Atomic']['name'], array('action'=>'view', $atomic['Atomic']['id']), array('title'=>'view this item'));?>
		</td>
		<td>
			<?php echo $atomic['Atomic']['open']; ?>
		</td>
		<td>
			<?php echo $atomic['Atomic']['type']; ?>
		</td>
		<td>
		<?php echo $html->link('Edit', array('action'=>'edit', $atomic['Atomic']['id']), array('class'=>'edit_item', 'title'=>'edit this item'));?>
		</td>
		<td>
			<?php echo $html->link('Delete', array('action'=>'delete', $atomic['Atomic']['id']), array('class'=>'delete_item', 'title'=>'delete this item'), 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>

</table>
<div id="page_nav" class="pagination">
	<?php echo $paginator->prev('« '.__('previous', true), array('class'=>'back prev'), null, array('class'=>'disabled prev'));?>
	<?php echo $paginator->numbers( array(null, '|'));?>
	<?php echo $paginator->next(__('next', true).' »', array('class'=>'back next'), null, array('class'=>'disabled next'));?>
</div>