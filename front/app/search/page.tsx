"use client";
import React, { useState } from 'react'
import { useSession } from 'next-auth/react'
import SearchForm from '../components/search/SearchForm';
import {
	AlertTriangle,
	AlertCircle,
	X
} from "lucide-react"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip"

export default function Home() {
	const { data: session } = useSession();
	const [isModalOpen, setIsModalOpen] = useState(false);

  const handleCloseModal = () => {
    setIsModalOpen(false);
  };

	return (
		session ? (
			<>
				<div className='flex flex-col space-y-4 p-10'>
					<div className='text-2xl md:text-3xl'>韓国コスメ検索
						<TooltipProvider>
							<Tooltip>
								<TooltipTrigger>
									<div className="ml-1 p-1 rounded-full bg-background-color border border-gray-200 shadow" id="my-modal" onClick={() => setIsModalOpen(true)}>
										<AlertCircle className="h-5 w-5" />
									</div>
								</TooltipTrigger>
								<TooltipContent>
									<p>検索時の注意点</p>
								</TooltipContent>
							</Tooltip>
						</TooltipProvider>
					</div>
					<input type="checkbox" id="weather-modal" className="modal-toggle" checked={isModalOpen} onChange={() => setIsModalOpen(!isModalOpen)} />
					<div className="modal" onClick={handleCloseModal}>
						<div className="modal-box text-left" onClick={e => e.stopPropagation()}>
							<div className="flex justify-end">
								<div onClick={handleCloseModal} className="btn btn-ghost btn-circle">
									<X />
								</div>
							</div>
							<div className="flex items-start mb-2">
								<AlertTriangle className="mr-1 h-5 w-5" />
								<p className='marked-text'>「お悩み」と「形態」は選択必須項目です。</p>
							</div>
						</div>
					</div>
					<SearchForm />
				</div>
			</>
		) : null
	);
}