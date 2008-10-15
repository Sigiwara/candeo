<h2>Fields<span class="count"><strong><?php echo $paginator->counter(array('format' => __('%count% ', true))); __('recorded')?></span></h2>
<div class="actions">
	<ul>
		<li><?php echo $html->link('Add', array('action'=>'add'), array('class'=>'btn')); ?></li>
	</ul>
</div>
<table>
	<tr>
		<th><?php echo $paginator->sort('Id', 'id'); ?></th>
		<th><?php echo $paginator->sort('Name', 'name'); ?></th>
		<th><?php echo $paginator->sort('Symbol', 'symbol'); ?></th>
		<th><?php echo $paginator->sort('Group', 'group'); ?></th>
		<th><?php echo $paginator->sort('Factor', 'factor'); ?></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	<?php foreach ($fields as $field) {
		?>
		<tr>
		<td><?php echo $field['Field']['id']; ?></td>
		<td><?php echo $field['Field']['name']; ?></td>
		<td><?php echo $field['Field']['symbol']; ?></td>
		<td><?php echo $field['Field']['group']; ?></td>
		<td><?php echo $field['Field']['factor']; ?></td>
		<td>
			<?php echo $html->link('Edit', array('action'=>'edit', $field['Field']['id']), array('class'=>'edit_item', 'title'=>'edit this item'));?>
		</td>
		<td>
			<?php echo $html->link('Delete', array('action'=>'delete', $field['Field']['id']), array('class'=>'delete_item', 'title'=>'delete this item'), 'Are you sure?')?>
		</td>
		</tr>
	<?php } ?>
</table>
<div id="page_nav" class="pagination">
	<?php echo $paginator->prev('« '.__('previous', true), array('class'=>'back prev'), null, array('class'=>'disabled prev'));?>
	<?php echo $paginator->numbers( array(null, '|'));?>
	<?php echo $paginator->next(__('next', true).' »', array('class'=>'back next'), null, array('class'=>'disabled next'));?>
</div>