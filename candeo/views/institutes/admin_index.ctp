<h2>Institutes<span class="count"><strong><?php echo $paginator->counter(array('format' => __('%count% ', true))); __('recorded')?></span></h2>
	<?php echo $html->link('Add', array('action'=>'add'), array('class'=>'edit')); ?>
<table>
	<tr>
		<th><?php echo $paginator->sort('Id', 'id'); ?></th>
		<th><?php echo $paginator->sort('Name', 'name'); ?></th>
		<th><?php echo $paginator->sort('Shortcut', 'shortcut'); ?></th>
		<th><?php echo $paginator->sort('Area', 'area'); ?></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	<?php
	$i = 0;
	foreach ($institutes as $institute):
	$class = null;
	if ($i++ % 2 == 0) {
		$class = ' class="altrow"';
	}
	?>
	<tr <?php echo $class; ?>>
		<td><?php echo $institute['Institute']['id']; ?></td>
		<td>
			<?php echo $html->link($institute['Institute']['name'], array('action'=>'view', $institute['Institute']['id']), array('title'=>'view this item')); ?>
		</td>
		<td>
			<?php echo $institute['Institute']['shortcut']; ?>
		</td>
		<td>
			<?php echo $institute['Institute']['area']; ?>
		</td>
		<td>
		<?php echo $html->link('Edit', array('action'=>'edit', $institute['Institute']['id']), array('class'=>'edit_item', 'title'=>'edit this item'));?>
		</td>
		<td>
			<?php echo $html->link('Delete', array('action'=>'delete', $institute['Institute']['id']), array('class'=>'delete_item', 'title'=>'delete this item'), 'Are you sure?')?>
		</td>
	</tr>
	<?php endforeach; ?>
</table>
<div id="page_nav" class="pagination">
	<?php echo $paginator->prev('« '.__('previous', true), array('class'=>'back prev'), null, array('class'=>'disabled prev'));?>
	<?php echo $paginator->numbers( array(null, '|'));?>
	<?php echo $paginator->next(__('next', true).' »', array('class'=>'back next'), null, array('class'=>'disabled next'));?>
</div>