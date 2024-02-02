<?php


namespace App\Controller;

use App\Model\TemplateConfig;
use App\Model\TemplateParam;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Class DefaultController
 * @package RosatomProcedures\DataAdmin\Controller
 */
class DefaultController extends AbstractController
{
    /**
     * @return Response
     */
    #[Route("/", name: "homepage")]
    public function index(): Response
    {
        return $this->render('mainPage.html.twig',[]);
    }
}