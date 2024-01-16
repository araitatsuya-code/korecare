import React from 'react';
import Link from 'next/link'
import DemonstrationResult from '../components/demo/DemonstrationResult';

export default function Demonstration() {
	return (
		<div className='bg-background-color min-h-screen text-text-color text-center'>
      <DemonstrationResult />
		</div>
	);
};