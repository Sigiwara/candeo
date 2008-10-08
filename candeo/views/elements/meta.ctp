<ul>
	<li><?php echo $html->link('Visualization', array('controller'=>'Pages', 'action'=>'home'), array('id'=>'visualization')); ?></li>
	<li><?php echo $html->link('Administration', array('controller'=>'institutes', 'action'=>'home'), array('id'=>'admin')); ?></li>
	<li><?php echo $html->link('Logout', array('controller'=>'users', 'action'=>'logout'), array('id'=>'default')); ?></li>
</ul>