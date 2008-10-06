<h2><?php echo $biological['Biological']['name']?></h2>
	<?php echo $html->link('Edit', '/biologicals/edit/'.$biological['Biological']['id'], array('class'=>'edit')); ?>
<dl>
	<dt>Activity</dt><dd><?php echo $biological['Biological']['activity']?></dd>
	<dt>Group</dt><dd><?php echo $biological['Biological']['group']?></dd>
	<dt>Security</dt><dd><?php echo $biological['Biological']['security']?></dd>
	<dt>Openness</dt><dd><?php echo $biological['Biological']['openness']?></dd>
</dl>
<div id="page_nav">
	<?php echo $html->link('Back', '/biologicals',  array('class'=>'back')); ?>
</div>