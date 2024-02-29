'use client';
import React, { useState } from 'react';
import { useProfile } from '../hooks/useProfile';
import useSWR from 'swr';
import axios from 'axios';
import { useSession } from 'next-auth/react';
import {
  CloudSun,
  Droplets,
  HelpCircle,
  SunMedium,
  Cloudy,
  Umbrella,
  Snowflake,
  CloudFog,
  Zap,
  X,
  Wind
} from "lucide-react"

const fetcher = async ([url, token]: [string, string | undefined]) => {
  const headers = token ? { Authorization: `Bearer ${token}` } : {};
  return axios.get(url, { headers }).then(res => res.data);
};

const calculateLevel = (value: number, max: number): number => {
  const level = Math.ceil((value / max) * 5);
  return level > 5 ? 5 : level;
};

interface LevelIconsProps {
  level: number;
  color: string;
  grayColor?: string;
  Icon: React.ElementType;
}

const LevelIcons: React.FC<LevelIconsProps> = ({ level, color, grayColor = "hsl(0, 0%, 80%)", Icon }) => {
  return (
    <div className="flex justify-center items-center">
      {[...Array(5)].map((_, index) => {
        const iconColor = index < level ? color : grayColor;
        return <div className="mx-1" key={index}><Icon size={24} color={iconColor} /></div>;
      })}
    </div>
  );
};

export default function Home() {
  const { data: session } = useSession();
  const { profile, isLoading: isProfileLoading } = useProfile();
  const [isModalOpen, setIsModalOpen] = useState(false);

  const handleCloseModal = () => {
    setIsModalOpen(false);
  };

  const { data: weatherData, error } = useSWR(
    profile ? [`${process.env.NEXT_PUBLIC_API_BASE_URL}/api/v1/weather?prefecture_name=${profile.prefecture || "東京都"}`, session?.accessToken] : null,
    fetcher,
    { refreshInterval: 300000 }
  );

  if (isProfileLoading || !weatherData) {
    return <div className="text-xl text-text-color bg-background-color min-h-screen w-full flex justify-center items-center">
      <div>Loading...<br /><br />잠깐만요.</div>
    </div>;
  }

  if (error) return <div className='text-center justify-between'>データの取得に失敗しました。</div>;

  const uviLevel = calculateLevel(weatherData?.current_uvi, 10);
  const humidityLevel = calculateLevel(weatherData?.current_humidity, 100);

  const uviColor = "#d4924f";
  const humidityColor = "#567485";

  const currentWeather = weatherData?.current_weather;
  const minTemp = Math.floor(weatherData?.min_temp);
  const maxTemp = Math.floor(weatherData?.max_temp);
  const currentUvi = Math.floor(weatherData?.current_uvi);
  const dailyMaxUvi = Math.floor(weatherData?.daily_max_uvi);

  const translateWeather = (weather: string): string => {
    const mapping: { [key: string]: string } = {
      'Clear': '晴れ',
      'Clouds': '曇り',
      'Rain': '雨',
      'Snow': '雪',
      'Mist': '霧',
      'Fog': '霧',
      'Thunderstorm': '雷雨',
      'Squall': '突風',
    };
    return mapping[weather] || weather;
  };

  const getWeatherIcon = (weather: string) => {
    const icons: { [key: string]: JSX.Element } = {
      '晴れ': <SunMedium className="inline-block mb-1" color="#FDB813" />,
      '曇り': <Cloudy className="inline-block mb-1" color="#B1B1B1" />,
      '雨': <Umbrella className="inline-block mb-1" color="#5171A5" />,
      '雪': <Snowflake className="inline-block mb-1" color="#75BFFF" />,
      '霧': <CloudFog className="inline-block mb-1" color="#8E8E8E" />,
      '雷雨': <Zap className="inline-block mb-1" color="#FFD700" />,
      '突風': <Wind className="inline-block mb-1" color="#6E7F80" />,
    };
    return icons[weather] || null;
  };

  return (
    <div className='p-6'>
      <p className='text-3xl z-10 py-1 px-3 mt-4 mb-8'>
        今日の{profile.prefecture || "東京都"}の天気情報
      </p>
      <div className="grid grid-cols-1 md:grid-cols-3 p-2 justify-center">
        <div className='shadow-md rounded-md overflow-hidden p-2 max-w-sm mx-auto w-full'>
          <p className="text-xl my-2">{translateWeather(currentWeather)} {getWeatherIcon(translateWeather(currentWeather))}</p>
          <p className="my-2">最高気温: <span style={{ color: '#de6c6c' }}>{maxTemp}°C</span></p>
          <p className="my-2">最低気温: <span style={{ color: '#498bc1' }}>{minTemp}°C</span></p>
        </div>
        <div className='shadow-md rounded-md overflow-hidden p-4 max-w-sm mx-auto w-full'>
          <p className="text-xl my-2">UV指数: {currentUvi}</p>
          <LevelIcons level={uviLevel} color={uviColor} Icon={CloudSun} />
          <p className="my-2">最高UV指数: {dailyMaxUvi}</p>
        </div>
        <div className='shadow-md rounded-md overflow-hidden p-4 max-w-sm mx-auto w-full'>
          <p className="text-xl my-2">湿度: {weatherData?.current_humidity}%</p>
          <LevelIcons level={humidityLevel} color={humidityColor} Icon={Droplets} />
          <p className="my-2">最低湿度: {weatherData?.daily_min_humidity}%</p>
        </div>
      </div>
      <div className="text-l flex items-center space-x-2 justify-center p-8 pb-20">
        <label htmlFor="weather-modal" className="text-md btn modal-button bg-background-color text-text-color shadow-md">
          UV指数と湿度の目安<HelpCircle className="ml-1 h-5 w-5" />
        </label>
      </div>
      <input type="checkbox" id="weather-modal" className="modal-toggle" checked={isModalOpen} onChange={() => setIsModalOpen(!isModalOpen)} />
      <div className="modal" onClick={handleCloseModal}>
        <div className="modal-box text-left" onClick={e => e.stopPropagation()}>
          <div className="flex justify-end">
            <button onClick={handleCloseModal} className="btn btn-ghost btn-circle">
              <X />
            </button>
          </div>
          <div className="flex items-start mb-2">
            <CloudSun className="mr-2 h-10 w-16" />
            <div>
              <p className="my-2 text-lg">UV指数</p>
              <p className="my-2 text-md">1〜2が「弱い」、3〜5が「中程度」、6以上が「強い」といわれています。</p>
              <p className="my-2 text-md">WHOによると、UV指数が3以上の場合は屋外での日焼け止めの利用、長袖や帽子の着用が推奨されています。</p>
            </div>
          </div>
          <div className="flex items-start">
            <Droplets className="mr-2 h-10 w-16" />
            <div>
              <p className="my-2 text-lg">湿度</p>
              <p className="my-2 text-md">お肌に最適な湿度は、50〜60%といわれています。</p>
              <p className="my-2 text-md">湿度が50%を下回っていたり、お肌の乾燥が気になった際はミスト化粧水やクリームを活用して、適度な保湿を心がけることをお勧めします。</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}